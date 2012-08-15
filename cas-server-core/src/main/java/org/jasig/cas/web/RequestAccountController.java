package org.jasig.cas.web;

import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class RequestAccountController extends AbstractController {

	private MailSender mailSender;

	private String requestView;

	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
	                                             HttpServletResponse response) throws Exception {
		String service = ServletRequestUtils.getStringParameter(request, "service");
		Map<String, Object> model = new HashMap<String, Object>();
		if (StringUtils.hasText(service)) {
			model.put("service", service);
		}

		if (request.getMethod().equals("GET")) {
			return new ModelAndView(this.requestView, model);
		} else if (WebUtils.hasSubmitParameter(request, "cancel")) {
			return new ModelAndView("redirect:/login", model);
		} else {
			String email = StringUtils.trimWhitespace(request.getParameter("email"));
			String name = StringUtils.trimWhitespace(request.getParameter("name"));

			if (StringUtils.hasText(email) && StringUtils.hasText(name)) {
				SimpleMailMessage message = new SimpleMailMessage();
				message.setFrom("no-reply-ensemble@collective.com");
				message.setTo("ensemble-creative@collective.com");
				message.setSubject("New Account Request");
				message.setText("Hi team,\n" +
						"\n" +
						"User " + name + " (email address is " + email + ") requested access to Demo pages. " +
						"Please grant access and inform user about his new credentials.\n" +
						"\n" +
						"Thanks,\n" +
						"Ensemble Demo Portal\n");
				try {
					this.mailSender.send(message);
				} catch (MailException e) {
					model.put("error", "We're unable to deliver your request right now. Please try again later!");
					return new ModelAndView(this.requestView, model);
				}
			}

			return new ModelAndView("redirect:/login", model);
		}
	}

	public void setRequestView(String requestView) {
		this.requestView = requestView;
	}

	public void setMailSender(MailSender mailSender) {
		this.mailSender = mailSender;
	}

}
