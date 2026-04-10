package com.hospital.dao.impl;

import com.hospital.dao.PatientDAO;
import com.hospital.model.Patient;
import com.hospital.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PatientDAOImpl implements PatientDAO {

    private Patient mapRow(ResultSet rs) throws Exception {
        return new Patient(
            rs.getString("patientId"),
            rs.getString("username"),
            rs.getString("password"),
            rs.getString("fullName"),
            rs.getString("diagnosis"),
            rs.getString("status"),
            rs.getString("appointmentTime")
        );
    }

    @Override
    public List<Patient> getAllPatients() {
        List<Patient> list = new ArrayList<>();
        String sql = "SELECT * FROM Patient";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    @Override
    public Patient getPatientById(String patientId) {
        String sql = "SELECT * FROM Patient WHERE patientId = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, patientId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    @Override
    public Patient getPatientByUsername(String username) {
        String sql = "SELECT * FROM Patient WHERE username = ?";
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
    public boolean addPatient(Patient p) {
        String sql = "INSERT INTO Patient (patientId, username, password, fullName, diagnosis, status, appointmentTime) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getPatientId());
            ps.setString(2, p.getUsername());
            ps.setString(3, p.getPassword());
            ps.setString(4, p.getFullName());
            ps.setString(5, p.getDiagnosis());
            ps.setString(6, p.getStatus());
            ps.setString(7, p.getAppointmentTime());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public boolean updatePatient(Patient p) {
        String sql = "UPDATE Patient SET fullName=?, diagnosis=?, status=?, appointmentTime=? WHERE patientId=?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getFullName());
            ps.setString(2, p.getDiagnosis());
            ps.setString(3, p.getStatus());
            ps.setString(4, p.getAppointmentTime());
            ps.setString(5, p.getPatientId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public boolean deletePatient(String patientId) {
        String sql = "DELETE FROM Patient WHERE patientId=?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, patientId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    @Override
    public int countTotal() {
        String sql = "SELECT COUNT(*) FROM Patient";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }
}
