package com.hospital.controller.admin;

import com.hospital.dao.impl.AppointmentDAOImpl;
import com.hospital.dao.impl.DoctorDAOImpl;
import com.hospital.dao.impl.PatientDAOImpl;
import com.hospital.model.Appointment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;

@WebServlet("/admin/appointments")
public class AdminAppointmentController extends HttpServlet {

    private final AppointmentDAOImpl appointmentDAO = new AppointmentDAOImpl();
    private final DoctorDAOImpl      doctorDAO      = new DoctorDAOImpl();
    private final PatientDAOImpl     patientDAO     = new PatientDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("appointments", appointmentDAO.getAllAppointments());
        req.setAttribute("doctors",      doctorDAO.getAllDoctors());
        req.setAttribute("patients",     patientDAO.getAllPatients());
        req.getRequestDispatcher("/admin/appointments.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            appointmentDAO.delete(req.getParameter("appointmentId"));
        } else if ("add".equals(action)) {
            Appointment a = new Appointment();
            a.setAppointmentId(req.getParameter("appointmentId"));
            a.setPatientId(req.getParameter("patientId"));
            a.setDoctorId(req.getParameter("doctorId"));
            a.setAppointmentDate(LocalDate.parse(req.getParameter("appointmentDate")));
            a.setAppointmentTime(LocalTime.parse(req.getParameter("appointmentTime")));
            a.setType(req.getParameter("type"));
            a.setStatus(req.getParameter("status"));
            a.setNotes(req.getParameter("notes"));
            appointmentDAO.insert(a);
        } else if ("update".equals(action)) {
            Appointment a = new Appointment();
            a.setAppointmentId(req.getParameter("appointmentId"));
            a.setPatientId(req.getParameter("patientId"));
            a.setDoctorId(req.getParameter("doctorId"));
            a.setAppointmentDate(LocalDate.parse(req.getParameter("appointmentDate")));
            a.setAppointmentTime(LocalTime.parse(req.getParameter("appointmentTime")));
            a.setType(req.getParameter("type"));
            a.setStatus(req.getParameter("status"));
            a.setNotes(req.getParameter("notes"));
            appointmentDAO.update(a);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/appointments");
    }
}
