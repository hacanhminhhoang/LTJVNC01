package com.hospital.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import java.io.IOException;

/**
 * CharacterEncodingFilter — forces UTF-8 on ALL requests and responses
 * so that Vietnamese text in POST form data is read correctly.
 * Must run BEFORE AuthFilter (order controlled by annotation + web.xml ordering).
 */
@WebFilter(urlPatterns = "/*", asyncSupported = true)
public class CharacterEncodingFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        // Force UTF-8 on the incoming request so Vietnamese POST data is read correctly
        if (request.getCharacterEncoding() == null ||
            !request.getCharacterEncoding().equalsIgnoreCase("UTF-8")) {
            request.setCharacterEncoding("UTF-8");
        }
        // Force UTF-8 on the response
        response.setCharacterEncoding("UTF-8");
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
