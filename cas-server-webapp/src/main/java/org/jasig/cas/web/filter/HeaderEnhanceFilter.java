package org.jasig.cas.web.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class HeaderEnhanceFilter implements Filter {

    private static final String ACCESS_CONTROL_ORIGIN = "Access-Control-Allow-Origin";
    private static final String ACCESS_CONTROL_CREDENTIALS = "Access-Control-Allow-Credentials";
    private static final String ACCESS_CONTROL_HEADERS = "Access-Control-Allow-Headers";
    private static final String ACCESS_CONTROL_VALUE = "*";

    public void init(FilterConfig filterConfig) throws ServletException {
    }

    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        response.addHeader(ACCESS_CONTROL_ORIGIN, ACCESS_CONTROL_VALUE);
        response.addHeader(ACCESS_CONTROL_HEADERS, ACCESS_CONTROL_VALUE);
        response.addHeader(ACCESS_CONTROL_CREDENTIALS, Boolean.TRUE.toString());

        filterChain.doFilter(servletRequest, servletResponse);
    }

    public void destroy() {
    }

}
