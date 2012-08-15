package org.jasig.cas.web;

import org.springframework.dao.IncorrectResultSizeDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
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
import javax.sql.DataSource;
import java.util.HashMap;
import java.util.Map;

public class ForgotPasswordController extends AbstractController {

	private MailSender mailSender;

	private DataSource dataSource;

	private String forgotView;

	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
	                                             HttpServletResponse response) throws Exception {
		String service = ServletRequestUtils.getStringParameter(request, "service");
		Map<String, Object> model = new HashMap<String, Object>();
		if (StringUtils.hasText(service)) {
			model.put("service", service);
		}

		if (request.getMethod().equals("GET")) {
			return new ModelAndView(this.forgotView, model);
		} else if (WebUtils.hasSubmitParameter(request, "cancel")) {
			return new ModelAndView("redirect:/login", model);
		} else {
			String email = StringUtils.trimWhitespace(request.getParameter("email"));
			if (StringUtils.hasText(email)) {
				JdbcTemplate template = new JdbcTemplate(this.dataSource);
				try {
					String password = template.queryForObject(
							"SELECT XmlData.value('(/User/Password)[1]', 'nvarchar(255)') AS password " +
									"FROM Entities e JOIN EntityData ed ON e.EntityId = ed.EntityId AND e.EntityDefId = 9 " +
									"WHERE XmlData.value('(/User/Email)[1]', 'nvarchar(255)') = ? AND State & 1 = 1",
							String.class, email);

					SimpleMailMessage message = new SimpleMailMessage();
					message.setFrom("no-reply-ensemble@collective.com");
					message.setTo(email);
					message.setSubject("Ensemble Password Reminder");
					message.setText("Hello,\n" +
							"Now you can login with\n" +
							"\n" +
							"Password: " + password + "\n" +
							"\n" +
							"Thanks,\n" +
							"Ensemble Team\n");
					try {
						this.mailSender.send(message);
					} catch (MailException e) {
						model.put("error", "Email address is not valid");
						return new ModelAndView(this.forgotView, model);
					}
				} catch (IncorrectResultSizeDataAccessException e) {
					model.put("error", "Email address is not registered in the system");
					return new ModelAndView(this.forgotView, model);
				}
			}
			return new ModelAndView("redirect:/login", model);
		}
	}

	public void setForgotView(String forgotView) {
		this.forgotView = forgotView;
	}

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public void setMailSender(MailSender mailSender) {
		this.mailSender = mailSender;
	}

}
