package com.hospital.dao.impl;

import com.hospital.dao.DepartmentDAO;
import com.hospital.model.Department;
import com.hospital.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DepartmentDAOImpl implements DepartmentDAO {

    @Override
    public List<Department> getAllDepartments() {
        List<Department> list = new ArrayList<>();
        String sql = "SELECT * FROM Department";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Department(
                        rs.getString("departmentId"),
                        rs.getNString("departmentName"),
                        rs.getNString("description")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Department getDepartmentById(String id) {
        String sql = "SELECT * FROM Department WHERE departmentId = ?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Department(
                            rs.getString("departmentId"),
                            rs.getNString("departmentName"),
                            rs.getNString("description")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean addDepartment(Department department) {
        String sql = "INSERT INTO Department (departmentId, departmentName, description) VALUES (?, ?, ?)";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, department.getDepartmentId());
            ps.setNString(2, department.getDepartmentName());
            ps.setNString(3, department.getDescription());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateDepartment(Department department) {
        String sql = "UPDATE Department SET departmentName = ?, description = ? WHERE departmentId = ?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setNString(1, department.getDepartmentName());
            ps.setNString(2, department.getDescription());
            ps.setString(3, department.getDepartmentId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteDepartment(String id) {
        String sql = "DELETE FROM Department WHERE departmentId = ?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
