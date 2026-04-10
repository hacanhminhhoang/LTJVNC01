package com.hospital.controller.admin;

import com.hospital.dao.impl.RevenueDAOImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/revenue")
public class AdminRevenueController extends HttpServlet {

    private final RevenueDAOImpl revenueDAO = new RevenueDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("revenues",      revenueDAO.getAllRevenue());
        req.setAttribute("totalRevenue",  revenueDAO.getTotalRevenue());
        req.setAttribute("todayRevenue",  revenueDAO.getTotalRevenueToday());
        req.getRequestDispatcher("/admin/revenue.jsp").forward(req, resp);
    }
}
