package com.hospital.controller.admin;

import com.hospital.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/admin/seed")
public class AdminSeedController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        out.println("<html><body><pre>");

        try (Connection conn = DBConnection.getInstance().getConnection()) {

            // ---- Appointments ----
            String aptSql = "INSERT INTO Appointment (appointmentId, patientId, doctorId, appointmentDate, appointmentTime, type, status, notes) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            Object[][] apts = {
                {"APT001","BN001","BS001","2026-04-08","08:30","Khám thường","Đã xác nhận","Tái khám sau 2 tuần"},
                {"APT002","BN002","BS001","2026-04-08","09:15","Khám thường","Chờ xác nhận",""},
                {"APT003","BN003","BS002","2026-04-08","10:00","Khám chuyên khoa","Đã xác nhận","Cần xét nghiệm máu"},
                {"APT004","BN004","BS001","2026-04-08","10:45","Khám thường","Đã hoàn thành",""},
                {"APT005","BN001","BS002","2026-04-09","14:00","Tái khám","Chờ xác nhận",""},
            };
            insertRows(conn, aptSql, apts, out, "Appointment");

            // ---- Revenue ----
            String revSql = "INSERT INTO Revenue (revenueId, amount, description, revenueDate, category, patientId) VALUES (?, ?, ?, ?, ?, ?)";
            Object[][] revs = {
                {"REV001", 250000, "Phí khám bệnh - BN001","2026-04-08","Khám bệnh","BN001"},
                {"REV002", 180000, "Phí khám bệnh - BN002","2026-04-08","Khám bệnh","BN002"},
                {"REV003", 450000, "Xét nghiệm máu - BN003","2026-04-08","Xét nghiệm","BN003"},
                {"REV004", 320000, "Phí khám bệnh - BN004","2026-04-08","Khám bệnh","BN004"},
                {"REV005",1200000, "Thuốc điều trị - BN001","2026-04-07","Dược phẩm","BN001"},
                {"REV006", 890000, "Thuốc điều trị - BN003","2026-04-07","Dược phẩm","BN003"},
                {"REV007", 250000, "Phí khám bệnh","2026-04-06","Khám bệnh","BN002"},
                {"REV008", 560000, "Siêu âm ổ bụng","2026-04-06","Xét nghiệm","BN004"},
            };
            insertRows(conn, revSql, revs, out, "Revenue");

            // ---- Partners ----
            String ptnSql = "INSERT INTO Partner (partnerId, partnerName, partnerType, contactEmail, phone, address, status, contractStart, contractEnd) VALUES (?,?,?,?,?,?,?,?,?)";
            Object[][] ptns = {
                {"PTN001","Công ty Dược Phúc Thành","Dược phẩm","phucthanh@pharma.vn","0281234567","123 Lê Lợi, Q1, TP.HCM","Đang hợp tác","2024-01-01","2027-01-01"},
                {"PTN002","Bệnh viện Chợ Rẫy","Liên kết","lienket@choray.vn","02838554269","201B Nguyễn Chí Thanh, Q5","Đang hợp tác","2023-06-01","2026-06-01"},
                {"PTN003","Thiết bị Y tế Minh Khoa","Thiết bị","info@minhkhoa.vn","0289876543","45 Đinh Tiên Hoàng, Bình Thạnh","Đang hợp tác","2025-01-15","2027-01-15"},
                {"PTN004","Bảo hiểm Y tế ABC","Bảo hiểm","contact@abcinsure.vn","19001234","Tòa nhà Vietcombank, Q3","Tạm dừng","2022-03-01","2025-03-01"},
            };
            insertRows(conn, ptnSql, ptns, out, "Partner");

            // ---- Reports ----
            String rptSql = "INSERT INTO Report (reportId, title, description, reportType, createdAt, createdBy, status) VALUES (?,?,?,?,GETDATE(),?,?)";
            Object[][] rpts = {
                {"RPT001","Máy điều hòa phòng 135 bị hỏng","Máy điều hòa phòng 135 không hoạt động từ sáng, bệnh nhân phản ánh nóng bức.","Sự cố","BS001","Mới"},
                {"RPT002","Thiếu thuốc Amoxicillin 500mg","Kho dược phẩm chỉ còn 85 hộp Amoxicillin, dưới mức tồn kho tối thiểu.","Kho dược","BS002","Đang xử lý"},
                {"RPT003","Vòi nước phòng vệ sinh tầng 2 bị rỉ","Cần thợ sửa chữa khẩn cấp, có nguy cơ trơn ngã.","Sự cố","BS001","Đã xử lý"},
            };
            insertRows(conn, rptSql, rpts, out, "Report");

            out.println("\n✅ ALL SEED DATA INSERTED SUCCESSFULLY!");

        } catch (Exception e) {
            out.println("\n❌ ERROR: " + e.getMessage());
            e.printStackTrace(out);
        }

        out.println("</pre></body></html>");
    }

    private void insertRows(Connection conn, String sql, Object[][] rows, PrintWriter out, String tableName) throws Exception {
        int count = 0;
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            for (Object[] row : rows) {
                for (int i = 0; i < row.length; i++) {
                    if (row[i] instanceof Integer) ps.setInt(i + 1, (Integer) row[i]);
                    else if (row[i] instanceof java.sql.Date) ps.setDate(i + 1, (java.sql.Date) row[i]);
                    else ps.setString(i + 1, row[i] != null ? row[i].toString() : null);
                }
                ps.addBatch();
                count++;
            }
            ps.executeBatch();
        }
        out.println("✓ Inserted " + count + " rows into " + tableName);
    }
}
