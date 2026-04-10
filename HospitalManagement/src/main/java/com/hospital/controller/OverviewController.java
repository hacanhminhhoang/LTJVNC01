package com.hospital.controller;

import com.hospital.service.PatientService;
import com.hospital.service.impl.PatientServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/overview")
public class OverviewController extends HttpServlet {
    private PatientService patientService = new PatientServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("patients", patientService.getRecentPatients());
        request.setAttribute("totalPatients", patientService.getTotalPatientsToday());
        request.setAttribute("appointments", patientService.getTotalAppointments());
        request.setAttribute("prescriptions", 85); // Mocks based on Figma
        request.setAttribute("recoveryRate", "94%");

        request.getRequestDispatcher("/overview.jsp").forward(request, response);
    }
}
