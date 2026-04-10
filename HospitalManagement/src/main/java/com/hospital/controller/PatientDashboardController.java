package com.hospital.controller;

import com.hospital.model.Patient;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/patient-dashboard")
public class PatientDashboardController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Patient patient = (Patient) session.getAttribute("loggedInUser");
        request.setAttribute("patient", patient);
        request.getRequestDispatcher("/patient_dashboard.jsp").forward(request, response);
    }
}
