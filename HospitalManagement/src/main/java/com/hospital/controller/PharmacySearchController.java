package com.hospital.controller;

import com.google.gson.Gson;
import com.hospital.dao.MedicineDAO;
import com.hospital.dao.impl.MedicineDAOImpl;
import com.hospital.model.Medicine;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/api/pharmacy/search")
public class PharmacySearchController extends HttpServlet {
    private final MedicineDAO medicineDAO = new MedicineDAOImpl();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String query = request.getParameter("q");
        String category = request.getParameter("category");

        try {
            List<Medicine> allMedicines = medicineDAO.getAllMedicines();

            List<Medicine> filtered = allMedicines.stream().filter(m -> {
                boolean matchQuery = query == null || query.isEmpty()
                        || m.getName().toLowerCase().contains(query.toLowerCase())
                        || m.getMedicineId().toLowerCase().contains(query.toLowerCase());
                // Nếu category rỗng hoặc "Tất cả" thì lấy tất cả
                boolean matchCategory = category == null || category.isEmpty()
                        || category.equals("Tất cả")
                        || m.getCategory().equalsIgnoreCase(category);
                return matchQuery && matchCategory;
            }).collect(Collectors.toList());

            response.getWriter().write(gson.toJson(filtered));

        } catch (Exception e) {
            e.printStackTrace(); // In ra Tomcat console để debug
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }
}
