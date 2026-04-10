package com.hospital.controller.admin;

import com.hospital.dao.impl.ReportDAOImpl;
import com.hospital.model.Report;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/reports")
public class AdminReportController extends HttpServlet {

    private final ReportDAOImpl reportDAO = new ReportDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("reports", reportDAO.getAll());
        req.getRequestDispatcher("/admin/reports.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("updateStatus".equals(action)) {
            reportDAO.updateStatus(req.getParameter("reportId"), req.getParameter("status"));
        } else if ("add".equals(action)) {
            Report r = new Report();
            r.setReportId(req.getParameter("reportId"));
            r.setTitle(req.getParameter("title"));
            r.setDescription(req.getParameter("description"));
            r.setReportType(req.getParameter("reportType"));
            r.setCreatedBy(req.getParameter("createdBy"));
            reportDAO.insert(r);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/reports");
    }
}
