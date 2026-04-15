package com.hospital.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {"/overview", "/pharmacy", "/diagnosis", "/api/*", "/patient-dashboard", "/admin/*"})
public class AuthFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest  request  = (HttpServletRequest)  req;
        HttpServletResponse response = (HttpServletResponse) res;

        HttpSession session  = request.getSession(false);
        boolean loggedIn = session != null && session.getAttribute("loggedInUser") != null;

        if (!loggedIn) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String role = (String) session.getAttribute("userRole");
        String uri  = request.getRequestURI();
        String ctx  = request.getContextPath();

        boolean isAdminRoute   = uri.startsWith(ctx + "/admin/");
        boolean isPatientRoute = uri.equals(ctx + "/patient-dashboard");
        boolean isDoctorRoute  = uri.startsWith(ctx + "/overview")
                              || uri.startsWith(ctx + "/pharmacy")
                              || uri.startsWith(ctx + "/diagnosis")
                              || uri.startsWith(ctx + "/api/");

        if ("ADMIN".equals(role) && !isAdminRoute) {
            response.sendRedirect(ctx + "/admin/dashboard");
            return;
        }
        if (!"ADMIN".equals(role) && isAdminRoute) {
            response.sendRedirect(ctx + "/login");
            return;
        }
        if ("PATIENT".equals(role) && isDoctorRoute) {
            response.sendRedirect(ctx + "/patient-dashboard");
            return;
        }
        if ("DOCTOR".equals(role) && isPatientRoute) {
            response.sendRedirect(ctx + "/overview");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {}
}
