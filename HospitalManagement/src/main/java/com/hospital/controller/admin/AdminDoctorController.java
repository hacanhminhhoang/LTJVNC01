package com.hospital.controller.admin;

import com.hospital.dao.impl.DoctorDAOImpl;
import com.hospital.model.Doctor;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/doctors")
public class AdminDoctorController extends HttpServlet {

    private final DoctorDAOImpl doctorDAO = new DoctorDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Doctor> doctors = doctorDAO.getAllDoctors();
        req.setAttribute("doctors", doctors);
        req.getRequestDispatcher("/admin/doctors.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            String id = req.getParameter("doctorId");
            doctorDAO.delete(id);
        } else if ("add".equals(action)) {
            Doctor d = new Doctor();
            d.setDoctorId(req.getParameter("doctorId"));
            d.setUsername(req.getParameter("username"));
            d.setPassword(req.getParameter("password"));
            d.setFullName(req.getParameter("fullName"));
            d.setSpecialty(req.getParameter("specialty"));
            d.setStatus(req.getParameter("status"));
            d.setPhoneNumber(req.getParameter("phoneNumber"));
            doctorDAO.insert(d);
        } else if ("update".equals(action)) {
            Doctor d = new Doctor();
            d.setDoctorId(req.getParameter("doctorId"));
            d.setFullName(req.getParameter("fullName"));
            d.setSpecialty(req.getParameter("specialty"));
            d.setStatus(req.getParameter("status"));
            d.setPhoneNumber(req.getParameter("phoneNumber"));
            doctorDAO.update(d);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/doctors");
    }
}
