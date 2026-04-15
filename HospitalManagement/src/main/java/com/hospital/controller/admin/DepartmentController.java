package com.hospital.controller.admin;

import com.hospital.dao.DepartmentDAO;
import com.hospital.dao.StaffDAO;
import com.hospital.dao.impl.DepartmentDAOImpl;
import com.hospital.dao.impl.StaffDAOImpl;
import com.hospital.model.Department;
import com.hospital.model.Staff;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/department")
public class DepartmentController extends HttpServlet {
    private DepartmentDAO departmentDAO;
    private StaffDAO staffDAO;

    @Override
    public void init() throws ServletException {
        departmentDAO = new DepartmentDAOImpl();
        staffDAO = new StaffDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        if (action.equals("list")) {
            List<Department> dList = departmentDAO.getAllDepartments();
            
            String selectedDept = request.getParameter("deptId");
            List<Staff> sList;
            if (selectedDept != null && !selectedDept.isEmpty()) {
                sList = staffDAO.getStaffByDepartment(selectedDept);
            } else {
                sList = staffDAO.getAllStaff();
            }

            request.setAttribute("departments", dList);
            request.setAttribute("staffs", sList);
            request.setAttribute("selectedDept", selectedDept);
            request.getRequestDispatcher("/admin/department.jsp").forward(request, response);
        } else if (action.equals("deleteDept")) {
            String id = request.getParameter("id");
            departmentDAO.deleteDepartment(id);
            response.sendRedirect(request.getContextPath() + "/admin/department");
        } else if (action.equals("deleteStaff")) {
            String id = request.getParameter("id");
            String deptId = request.getParameter("deptId");
            staffDAO.deleteStaff(id);
            response.sendRedirect(request.getContextPath() + "/admin/department" + (deptId != null ? "?deptId="+deptId : ""));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("addDept".equals(action)) {
            String id = request.getParameter("departmentId");
            String name = request.getParameter("departmentName");
            String desc = request.getParameter("description");
            Department d = new Department(id, name, desc);
            departmentDAO.addDepartment(d);
            response.sendRedirect(request.getContextPath() + "/admin/department");
        } else if ("editDept".equals(action)) {
            String id = request.getParameter("departmentId");
            String name = request.getParameter("departmentName");
            String desc = request.getParameter("description");
            Department d = new Department(id, name, desc);
            departmentDAO.updateDepartment(d);
            response.sendRedirect(request.getContextPath() + "/admin/department");
        } else if ("addStaff".equals(action)) {
            String id = request.getParameter("staffId");
            String name = request.getParameter("fullName");
            String role = request.getParameter("role");
            String deptId = request.getParameter("departmentId");
            String phone = request.getParameter("phoneNumber");
            String email = request.getParameter("email");
            Staff s = new Staff(id, name, role, deptId, phone, email);
            staffDAO.addStaff(s);
            response.sendRedirect(request.getContextPath() + "/admin/department?deptId=" + deptId);
        } else if ("editStaff".equals(action)) {
            String id = request.getParameter("staffId");
            String name = request.getParameter("fullName");
            String role = request.getParameter("role");
            String deptId = request.getParameter("departmentId");
            String phone = request.getParameter("phoneNumber");
            String email = request.getParameter("email");
            Staff s = new Staff(id, name, role, deptId, phone, email);
            staffDAO.updateStaff(s);
            response.sendRedirect(request.getContextPath() + "/admin/department?deptId=" + deptId);
        }
    }
}
