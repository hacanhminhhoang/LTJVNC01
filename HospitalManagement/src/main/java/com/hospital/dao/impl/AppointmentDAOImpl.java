package com.hospital.dao.impl;

import com.hospital.dao.AppointmentDAO;
import com.hospital.model.Appointment;
import com.hospital.util.DBConnection;

import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAOImpl implements AppointmentDAO {

    private static final String SELECT_ALL =
        "SELECT a.appointmentId, a.patientId, p.fullName AS patientName, " +
        "a.doctorId, d.fullName AS doctorName, d.specialty AS doctorSpecialty, " +
        "a.appointmentDate, a.appointmentTime, a.type, a.status, a.notes " +
        "FROM Appointment a " +
        "LEFT JOIN Patient p ON a.patientId = p.patientId " +
        "LEFT JOIN Doctor d ON a.doctorId = d.doctorId " +
        "ORDER BY a.appointmentDate DESC, a.appointmentTime ASC";

    @Override
    public List<Appointment> getAllAppointments() {
        List<Appointment> list = new ArrayList<>();
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Appointment getById(String id) {
        String sql = SELECT_ALL.replace("ORDER BY a.appointmentDate DESC, a.appointmentTime ASC",
                                        "WHERE a.appointmentId = ?");
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean insert(Appointment a) {
        String sql = "INSERT INTO Appointment (appointmentId, patientId, doctorId, appointmentDate, appointmentTime, type, status, notes) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, a.getAppointmentId());
            ps.setString(2, a.getPatientId());
            ps.setString(3, a.getDoctorId());
            ps.setDate(4, Date.valueOf(a.getAppointmentDate()));
            ps.setTime(5, Time.valueOf(a.getAppointmentTime()));
            ps.setString(6, a.getType());
            ps.setString(7, a.getStatus());
            ps.setString(8, a.getNotes());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean update(Appointment a) {
        String sql = "UPDATE Appointment SET patientId=?, doctorId=?, appointmentDate=?, appointmentTime=?, type=?, status=?, notes=? WHERE appointmentId=?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, a.getPatientId());
            ps.setString(2, a.getDoctorId());
            ps.setDate(3, Date.valueOf(a.getAppointmentDate()));
            ps.setTime(4, Time.valueOf(a.getAppointmentTime()));
            ps.setString(5, a.getType());
            ps.setString(6, a.getStatus());
            ps.setString(7, a.getNotes());
            ps.setString(8, a.getAppointmentId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(String id) {
        String sql = "DELETE FROM Appointment WHERE appointmentId = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public int countTotal() {
        String sql = "SELECT COUNT(*) FROM Appointment";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    private Appointment mapRow(ResultSet rs) throws SQLException {
        Appointment a = new Appointment();
        a.setAppointmentId(rs.getString("appointmentId"));
        a.setPatientId(rs.getString("patientId"));
        a.setPatientName(rs.getString("patientName"));
        a.setDoctorId(rs.getString("doctorId"));
        a.setDoctorName(rs.getString("doctorName"));
        a.setDoctorSpecialty(rs.getString("doctorSpecialty"));
        Date d = rs.getDate("appointmentDate");
        if (d != null) a.setAppointmentDate(d.toLocalDate());
        Time t = rs.getTime("appointmentTime");
        if (t != null) a.setAppointmentTime(t.toLocalTime());
        a.setType(rs.getString("type"));
        a.setStatus(rs.getString("status"));
        a.setNotes(rs.getString("notes"));
        return a;
    }
}
