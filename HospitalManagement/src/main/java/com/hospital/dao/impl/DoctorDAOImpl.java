package com.hospital.dao.impl;

import com.hospital.dao.DoctorDAO;
import com.hospital.model.Doctor;
import com.hospital.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DoctorDAOImpl implements DoctorDAO {

    private Doctor mapRow(ResultSet rs) throws SQLException {
        return new Doctor(
            rs.getString("doctorId"),
            rs.getString("username"),
            rs.getString("password"),
            rs.getString("fullName"),
            rs.getString("specialty"),
            rs.getString("status"),
            rs.getString("phoneNumber")
        );
    }

    @Override
    public Doctor getDoctorByUsername(String username) {
        String sql = "SELECT * FROM Doctor WHERE username = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    @Override
    public List<Doctor> getAllDoctors() {
        List<Doctor> list = new ArrayList<>();
        String sql = "SELECT * FROM Doctor ORDER BY fullName";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public int countTotal() {
        String sql = "SELECT COUNT(*) FROM Doctor";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    @Override
    public boolean insert(Doctor d) {
        String sql = "INSERT INTO Doctor (doctorId, username, password, fullName, specialty, status, phoneNumber) VALUES (?,?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, d.getDoctorId());
            ps.setString(2, d.getUsername());
            ps.setString(3, d.getPassword());
            ps.setString(4, d.getFullName());
            ps.setString(5, d.getSpecialty());
            ps.setString(6, d.getStatus());
            ps.setString(7, d.getPhoneNumber());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public boolean update(Doctor d) {
        String sql = "UPDATE Doctor SET fullName=?, specialty=?, status=?, phoneNumber=? WHERE doctorId=?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, d.getFullName());
            ps.setString(2, d.getSpecialty());
            ps.setString(3, d.getStatus());
            ps.setString(4, d.getPhoneNumber());
            ps.setString(5, d.getDoctorId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public boolean delete(String doctorId) {
        String sql = "DELETE FROM Doctor WHERE doctorId = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, doctorId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }
}
