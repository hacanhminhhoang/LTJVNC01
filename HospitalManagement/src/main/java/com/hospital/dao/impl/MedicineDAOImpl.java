package com.hospital.dao.impl;

import com.hospital.dao.MedicineDAO;
import com.hospital.model.Medicine;
import com.hospital.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MedicineDAOImpl implements MedicineDAO {

    @Override
    public List<Medicine> getAllMedicines() {
        List<Medicine> list = new ArrayList<>();
        String sql = "SELECT * FROM Medicine";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
             
            while (rs.next()) {
                Medicine m = new Medicine(
                    rs.getString("medicineId"),
                    rs.getString("name"),
                    rs.getString("category"),
                    rs.getInt("quantity"),
                    rs.getDouble("price"),
                    rs.getDate("expirationDate")
                );
                list.add(m);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Medicine getMedicineById(String medicineId) {
        String sql = "SELECT * FROM Medicine WHERE medicineId = ?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, medicineId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Medicine(
                        rs.getString("medicineId"),
                        rs.getString("name"),
                        rs.getString("category"),
                        rs.getInt("quantity"),
                        rs.getDouble("price"),
                        rs.getDate("expirationDate")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean addMedicine(Medicine medicine) {
        String sql = "INSERT INTO Medicine (medicineId, name, category, quantity, price, expirationDate) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, medicine.getMedicineId());
            ps.setString(2, medicine.getName());
            ps.setString(3, medicine.getCategory());
            ps.setInt(4, medicine.getQuantity());
            ps.setDouble(5, medicine.getPrice());
            ps.setDate(6, medicine.getExpirationDate());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateMedicine(Medicine medicine) {
        String sql = "UPDATE Medicine SET name=?, category=?, quantity=?, price=?, expirationDate=? WHERE medicineId=?";
        try (Connection conn = DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, medicine.getName());
            ps.setString(2, medicine.getCategory());
            ps.setInt(3, medicine.getQuantity());
            ps.setDouble(4, medicine.getPrice());
            ps.setDate(5, medicine.getExpirationDate());
            ps.setString(6, medicine.getMedicineId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
