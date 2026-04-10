package com.hospital.dao.impl;

import com.hospital.dao.ReportDAO;
import com.hospital.model.Report;
import com.hospital.util.DBConnection;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class ReportDAOImpl implements ReportDAO {

    @Override
    public List<Report> getAll() {
        List<Report> list = new ArrayList<>();
        String sql = "SELECT * FROM Report ORDER BY createdAt DESC";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Report r = new Report();
                r.setReportId(rs.getString("reportId"));
                r.setTitle(rs.getString("title"));
                r.setDescription(rs.getString("description"));
                r.setReportType(rs.getString("reportType"));
                Timestamp ts = rs.getTimestamp("createdAt");
                if (ts != null) r.setCreatedAt(ts.toLocalDateTime());
                r.setCreatedBy(rs.getString("createdBy"));
                r.setStatus(rs.getString("status"));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean insert(Report r) {
        String sql = "INSERT INTO Report (reportId, title, description, reportType, createdAt, createdBy, status) VALUES (?,?,?,?,GETDATE(),?,?)";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, r.getReportId());
            ps.setString(2, r.getTitle());
            ps.setString(3, r.getDescription());
            ps.setString(4, r.getReportType());
            ps.setString(5, r.getCreatedBy());
            ps.setString(6, r.getStatus() != null ? r.getStatus() : "Mới");
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateStatus(String reportId, String status) {
        String sql = "UPDATE Report SET status = ? WHERE reportId = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setString(2, reportId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
