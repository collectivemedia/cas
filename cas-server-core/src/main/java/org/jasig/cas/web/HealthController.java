package org.jasig.cas.web;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Collections;

public class HealthController extends AbstractController {

	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request,
	                                             HttpServletResponse response) throws Exception {
		return new ModelAndView("health", Collections.singletonMap("status", "OK"));
	}

}
