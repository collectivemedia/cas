package org.jasig.cas.web.bind;

import org.jasig.cas.authentication.principal.Credentials;
import org.jasig.cas.authentication.principal.RememberMeUsernamePasswordCredentials;
import org.jasig.cas.authentication.principal.UsernamePasswordCredentials;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;

public class TrimmingCredentialsBinder implements CredentialsBinder {

	public void bind(HttpServletRequest request, Credentials credentials) {
		UsernamePasswordCredentials up = (UsernamePasswordCredentials) credentials;
		up.setUsername(StringUtils.trimWhitespace(up.getUsername()));
	}

	public boolean supports(Class<?> clazz) {
		return !(clazz == null)
				&& (clazz.equals(UsernamePasswordCredentials.class)
					|| clazz.equals(RememberMeUsernamePasswordCredentials.class));
	}

}
