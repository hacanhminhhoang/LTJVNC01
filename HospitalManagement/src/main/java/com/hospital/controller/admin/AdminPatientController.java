package com.hospital.controller.admin;

import com.hospital.dao.impl.PatientDAOImpl;
import com.hospital.model.Patient;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/patients")
public class AdminPatientController extends HttpServlet {

    private final PatientDAOImpl patientDAO = new PatientDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Patient> patients = patientDAO.getAllPatients();
        req.setAttribute("patients", patients);
        req.getRequestDispatcher("/admin/patients.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            patientDAO.delete(req.getParameter("patientId"));
        } else if ("add".equals(action)) {
            Patient p = new Patient();
            p.setPatientId(req.getParameter("patientId"));
            p.setUsername(req.getParameter("username"));
            p.setPassword(req.getParameter("password"));
            p.setFullName(req.getParameter("fullName"));
            p.setDiagnosis(req.getParameter("diagnosis"));
            p.setStatus(req.getParameter("status"));
            p.setAppointmentTime(req.getParameter("appointmentTime"));
            patientDAO.insert(p);
        } else if ("update".equals(action)) {
            Patient p = new Patient();
            p.setPatientId(req.getParameter("patientId"));
            p.setFullName(req.getParameter("fullName"));
            p.setDiagnosis(req.getParameter("diagnosis"));
            p.setStatus(req.getParameter("status"));
            p.setAppointmentTime(req.getParameter("appointmentTime"));
            patientDAO.update(p);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/patients");
    }
}
