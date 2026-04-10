package com.hospital.controller.admin;

import com.hospital.dao.impl.PartnerDAOImpl;
import com.hospital.model.Partner;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/admin/partners")
public class AdminPartnerController extends HttpServlet {

    private final PartnerDAOImpl partnerDAO = new PartnerDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("partners", partnerDAO.getAll());
        req.getRequestDispatcher("/admin/partners.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if ("delete".equals(action)) {
            partnerDAO.delete(req.getParameter("partnerId"));
        } else if ("add".equals(action)) {
            Partner p = buildPartner(req);
            p.setPartnerId(req.getParameter("partnerId"));
            partnerDAO.insert(p);
        } else if ("update".equals(action)) {
            Partner p = buildPartner(req);
            p.setPartnerId(req.getParameter("partnerId"));
            partnerDAO.update(p);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/partners");
    }

    private Partner buildPartner(HttpServletRequest req) {
        Partner p = new Partner();
        p.setPartnerName(req.getParameter("partnerName"));
        p.setPartnerType(req.getParameter("partnerType"));
        p.setContactEmail(req.getParameter("contactEmail"));
        p.setPhone(req.getParameter("phone"));
        p.setAddress(req.getParameter("address"));
        p.setStatus(req.getParameter("status"));
        String cs = req.getParameter("contractStart");
        String ce = req.getParameter("contractEnd");
        if (cs != null && !cs.isEmpty()) p.setContractStart(LocalDate.parse(cs));
        if (ce != null && !ce.isEmpty()) p.setContractEnd(LocalDate.parse(ce));
        return p;
    }
}
