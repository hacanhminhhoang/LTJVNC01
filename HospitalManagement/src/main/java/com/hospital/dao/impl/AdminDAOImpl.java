package com.hospital.dao.impl;

import com.hospital.dao.AdminDAO;
import com.hospital.model.Admin;
import com.hospital.util.DBConnection;

import java.sql.*;

public class AdminDAOImpl implements AdminDAO {
    @Override
    public Admin getAdminByUsername(String username) {
        String sql = "SELECT * FROM Admin WHERE username = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Admin(
                        rs.getString("adminId"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("fullName"),
                        rs.getString("email"),
                        rs.getString("avatarUrl")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
