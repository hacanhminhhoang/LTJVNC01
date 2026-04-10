package com.hospital.controller;

import com.hospital.model.Admin;
import com.hospital.model.Doctor;
import com.hospital.model.Patient;
import com.hospital.service.impl.AuthServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private final AuthServiceImpl authService = new AuthServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 1) Thử đăng nhập với tài khoản Admin
        Admin admin = authService.loginAdmin(username, password);
        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", admin);
            session.setAttribute("userRole", "ADMIN");
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        // 2) Thử đăng nhập với tài khoản Bác sĩ
        Doctor doctor = authService.login(username, password);
        if (doctor != null) {
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", doctor);
            session.setAttribute("userRole", "DOCTOR");
            response.sendRedirect(request.getContextPath() + "/overview");
            return;
        }

        // 3) Thử đăng nhập với tài khoản Bệnh nhân
        Patient patient = authService.loginPatient(username, password);
        if (patient != null) {
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", patient);
            session.setAttribute("userRole", "PATIENT");
            response.sendRedirect(request.getContextPath() + "/patient-dashboard");
            return;
        }

        // 4) Sai thông tin
        request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác!");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}
