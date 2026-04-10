package com.hospital.controller;

import com.hospital.service.PharmacyService;
import com.hospital.service.impl.PharmacyServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/pharmacy")
public class PharmacyController extends HttpServlet {
    private PharmacyService pharmacyService = new PharmacyServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("medicines", pharmacyService.getAllInventory());
        request.setAttribute("totalCategories", pharmacyService.getTotalCategories());
        request.setAttribute("lowStock", pharmacyService.getLowStockCount());
        request.setAttribute("outOfStock", pharmacyService.getOutOfStockCount());

        request.getRequestDispatcher("/pharmacy.jsp").forward(request, response);
    }
}
