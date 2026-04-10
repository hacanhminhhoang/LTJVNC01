package com.hospital.controller;

import com.google.gson.Gson;
import com.hospital.dao.PatientDAO;
import com.hospital.dao.impl.PatientDAOImpl;
import com.hospital.model.Patient;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/api/diagnosis/search")
public class DiagnosisSearchController extends HttpServlet {
    private final PatientDAO patientDAO = new PatientDAOImpl();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String query = request.getParameter("q");

        List<Patient> allPatients = patientDAO.getAllPatients();

        List<Patient> filtered = allPatients.stream().filter(p -> {
            return query == null || query.isEmpty() ||
                   p.getFullName().toLowerCase().contains(query.toLowerCase()) || 
                   p.getPatientId().toLowerCase().contains(query.toLowerCase());
        }).collect(Collectors.toList());

        response.getWriter().write(gson.toJson(filtered));
    }
}
