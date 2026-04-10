package com.hospital.dao.impl;

import com.hospital.dao.RevenueDAO;
import com.hospital.model.Revenue;
import com.hospital.util.DBConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RevenueDAOImpl implements RevenueDAO {

    @Override
    public List<Revenue> getAllRevenue() {
        List<Revenue> list = new ArrayList<>();
        String sql = "SELECT * FROM Revenue ORDER BY revenueDate DESC";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Revenue r = new Revenue();
                r.setRevenueId(rs.getString("revenueId"));
                r.setAmount(rs.getBigDecimal("amount"));
                r.setDescription(rs.getString("description"));
                Date d = rs.getDate("revenueDate");
                if (d != null) r.setRevenueDate(d.toLocalDate());
                r.setCategory(rs.getString("category"));
                r.setPatientId(rs.getString("patientId"));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public BigDecimal getTotalRevenue() {
        String sql = "SELECT ISNULL(SUM(amount), 0) FROM Revenue";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getBigDecimal(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    @Override
    public BigDecimal getTotalRevenueToday() {
        String sql = "SELECT ISNULL(SUM(amount), 0) FROM Revenue WHERE revenueDate = CAST(GETDATE() AS DATE)";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getBigDecimal(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }
}
