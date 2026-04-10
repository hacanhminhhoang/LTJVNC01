package com.hospital.controller.admin;

import com.hospital.dao.impl.AppointmentDAOImpl;
import com.hospital.dao.impl.PatientDAOImpl;
import com.hospital.dao.impl.RevenueDAOImpl;
import com.hospital.dao.impl.ReportDAOImpl;
import com.hospital.dao.impl.DoctorDAOImpl;
import com.hospital.model.Admin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/admin/dashboard")
public class AdminDashboardController extends HttpServlet {

    private final PatientDAOImpl     patientDAO     = new PatientDAOImpl();
    private final DoctorDAOImpl      doctorDAO      = new DoctorDAOImpl();
    private final AppointmentDAOImpl appointmentDAO = new AppointmentDAOImpl();
    private final RevenueDAOImpl     revenueDAO     = new RevenueDAOImpl();
    private final ReportDAOImpl      reportDAO      = new ReportDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Admin admin = (session != null) ? (Admin) session.getAttribute("loggedInUser") : null;

        // Stats
        req.setAttribute("totalPatients",    patientDAO.countTotal());
        req.setAttribute("totalDoctors",     doctorDAO.countTotal());
        req.setAttribute("totalAppointments", appointmentDAO.countTotal());
        req.setAttribute("totalRevenue",     revenueDAO.getTotalRevenue());

        // Recent data for widgets
        req.setAttribute("appointments",     appointmentDAO.getAllAppointments());
        req.setAttribute("reports",          reportDAO.getAll());
        req.setAttribute("admin",            admin);

        req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
    }
}
