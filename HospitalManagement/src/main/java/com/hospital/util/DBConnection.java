package com.hospital.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String SERVER_NAME = "DESKTOP-VSMU4N8\\KETHONGTRILOAIBO";
    private static final String DB_NAME = "HospitalManagement";
    private static final String PORT = "1433";
    private static final String USER = "sa";
    private static final String PASS = "12345";
    
    private static final String DB_URL = "jdbc:sqlserver://" + SERVER_NAME + ":" + PORT
            + ";databaseName=" + DB_NAME
            + ";encrypt=true;trustServerCertificate=true"
            + ";sendStringParametersAsUnicode=true"
            + ";characterEncoding=UTF-8";

    private static DBConnection instance;

    private DBConnection() {
        try {
            // Khởi tạo Driver cho SQL Server
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("SQL Server driver not found!", e);
        }
    }

    public static synchronized DBConnection getInstance() {
        if (instance == null) {
            instance = new DBConnection();
        }
        return instance;
    }

    public Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, USER, PASS);
    }
    
    // Testing the connection
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getInstance().getConnection()) {
            System.out.println("Kiểm tra DBConnection: Kết nối SQL Server thành công !");
        } catch (Exception e) {
            System.err.println("Kiểm tra DBConnection: Kết nối SQL Server thất bại !");
            e.printStackTrace();
        }
    }
}
