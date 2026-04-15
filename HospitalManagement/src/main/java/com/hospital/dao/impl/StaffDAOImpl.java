package com.hospital.dao.impl;

import com.hospital.dao.StaffDAO;
import com.hospital.model.Staff;
import com.hospital.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class StaffDAOImpl implements StaffDAO {

    @Override
    public List<Staff> getAllStaff() {
        List<Staff> list = new ArrayList<>();
        String sql = "SELECT s.*, d.departmentName FROM Staff s LEFT JOIN Department d ON s.departmentId = d.departmentId";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Staff s = new Staff(
                        rs.getString("staffId"),
                        rs.getNString("fullName"),
                        rs.getNString("role"),
                        rs.getString("departmentId"),
                        rs.getString("phoneNumber"),
                        rs.getString("email")
                );
                s.setDepartmentName(rs.getNString("departmentName"));
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Staff> getStaffByDepartment(String departmentId) {
        List<Staff> list = new ArrayList<>();
        String sql = "SELECT s.*, d.departmentName FROM Staff s LEFT JOIN Department d ON s.departmentId = d.departmentId WHERE s.departmentId = ?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, departmentId);
            try(ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Staff s = new Staff(
                            rs.getString("staffId"),
                            rs.getNString("fullName"),
                            rs.getNString("role"),
                            rs.getString("departmentId"),
                            rs.getString("phoneNumber"),
                            rs.getString("email")
                    );
                    s.setDepartmentName(rs.getNString("departmentName"));
                    list.add(s);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Staff getStaffById(String id) {
        String sql = "SELECT s.*, d.departmentName FROM Staff s LEFT JOIN Department d ON s.departmentId = d.departmentId WHERE s.staffId = ?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Staff s = new Staff(
                            rs.getString("staffId"),
                            rs.getNString("fullName"),
                            rs.getNString("role"),
                            rs.getString("departmentId"),
                            rs.getString("phoneNumber"),
                            rs.getString("email")
                    );
                    s.setDepartmentName(rs.getNString("departmentName"));
                    return s;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean addStaff(Staff staff) {
        String sql = "INSERT INTO Staff (staffId, fullName, role, departmentId, phoneNumber, email) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, staff.getStaffId());
            ps.setNString(2, staff.getFullName());
            ps.setNString(3, staff.getRole());
            ps.setString(4, staff.getDepartmentId());
            ps.setString(5, staff.getPhoneNumber());
            ps.setString(6, staff.getEmail());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateStaff(Staff staff) {
        String sql = "UPDATE Staff SET fullName = ?, role = ?, departmentId = ?, phoneNumber = ?, email = ? WHERE staffId = ?";
        try (Connection con = DBConnection.getInstance().getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setNString(1, staff.getFullName());
            ps.setNString(2, staff.getRole());
            ps.setString(3, staff.getDepartmentId());
            ps.setString(4, staff.getPhoneNumber());
            ps.setString(5, staff.getEmail());
            ps.setString(6, staff.getStaffId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteStaff(String id) {
        String sql = "DELETE FROM Staff WHERE staffId = ?";
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
