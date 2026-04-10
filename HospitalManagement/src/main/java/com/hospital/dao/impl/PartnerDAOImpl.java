package com.hospital.dao.impl;

import com.hospital.dao.PartnerDAO;
import com.hospital.model.Partner;
import com.hospital.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PartnerDAOImpl implements PartnerDAO {

    @Override
    public List<Partner> getAll() {
        List<Partner> list = new ArrayList<>();
        String sql = "SELECT * FROM Partner ORDER BY partnerName";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
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
    public Partner getById(String id) {
        String sql = "SELECT * FROM Partner WHERE partnerId = ?";
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
    public boolean insert(Partner p) {
        String sql = "INSERT INTO Partner (partnerId, partnerName, partnerType, contactEmail, phone, address, status, contractStart, contractEnd) VALUES (?,?,?,?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getPartnerId());
            ps.setString(2, p.getPartnerName());
            ps.setString(3, p.getPartnerType());
            ps.setString(4, p.getContactEmail());
            ps.setString(5, p.getPhone());
            ps.setString(6, p.getAddress());
            ps.setString(7, p.getStatus());
            ps.setDate(8, p.getContractStart() != null ? Date.valueOf(p.getContractStart()) : null);
            ps.setDate(9, p.getContractEnd() != null ? Date.valueOf(p.getContractEnd()) : null);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean update(Partner p) {
        String sql = "UPDATE Partner SET partnerName=?, partnerType=?, contactEmail=?, phone=?, address=?, status=?, contractStart=?, contractEnd=? WHERE partnerId=?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getPartnerName());
            ps.setString(2, p.getPartnerType());
            ps.setString(3, p.getContactEmail());
            ps.setString(4, p.getPhone());
            ps.setString(5, p.getAddress());
            ps.setString(6, p.getStatus());
            ps.setDate(7, p.getContractStart() != null ? Date.valueOf(p.getContractStart()) : null);
            ps.setDate(8, p.getContractEnd() != null ? Date.valueOf(p.getContractEnd()) : null);
            ps.setString(9, p.getPartnerId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(String id) {
        String sql = "DELETE FROM Partner WHERE partnerId = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private Partner mapRow(ResultSet rs) throws SQLException {
        Partner p = new Partner();
        p.setPartnerId(rs.getString("partnerId"));
        p.setPartnerName(rs.getString("partnerName"));
        p.setPartnerType(rs.getString("partnerType"));
        p.setContactEmail(rs.getString("contactEmail"));
        p.setPhone(rs.getString("phone"));
        p.setAddress(rs.getString("address"));
        p.setStatus(rs.getString("status"));
        Date cs = rs.getDate("contractStart");
        if (cs != null) p.setContractStart(cs.toLocalDate());
        Date ce = rs.getDate("contractEnd");
        if (ce != null) p.setContractEnd(ce.toLocalDate());
        return p;
    }
}
