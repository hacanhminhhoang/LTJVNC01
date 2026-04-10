-- ============================================
-- Admin Panel Extension SQL Script
-- Run this on top of the existing database.sql
-- ============================================

USE HospitalManagement;
GO

-- Table: Admin
CREATE TABLE Admin (
    adminId VARCHAR(10) PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    fullName NVARCHAR(100) NOT NULL,
    email VARCHAR(100),
    avatarUrl VARCHAR(255) DEFAULT ''
);
GO

-- Table: Appointment (Lịch hẹn)
CREATE TABLE Appointment (
    appointmentId VARCHAR(15) PRIMARY KEY,
    patientId VARCHAR(10) REFERENCES Patient(patientId),
    doctorId VARCHAR(10) REFERENCES Doctor(doctorId),
    appointmentDate DATE NOT NULL,
    appointmentTime TIME NOT NULL,
    type NVARCHAR(50) DEFAULT N'Khám thường',
    status NVARCHAR(50) DEFAULT N'Chờ xác nhận',
    notes NVARCHAR(500)
);
GO

-- Table: Revenue (Doanh thu)
CREATE TABLE Revenue (
    revenueId VARCHAR(15) PRIMARY KEY,
    amount DECIMAL(18,2) NOT NULL,
    description NVARCHAR(300),
    revenueDate DATE NOT NULL,
    category NVARCHAR(50) DEFAULT N'Khám bệnh',
    patientId VARCHAR(10)
);
GO

-- Table: Partner (Đối tác)
CREATE TABLE Partner (
    partnerId VARCHAR(15) PRIMARY KEY,
    partnerName NVARCHAR(150) NOT NULL,
    partnerType NVARCHAR(50) DEFAULT N'Dược phẩm',
    contactEmail VARCHAR(100),
    phone VARCHAR(20),
    address NVARCHAR(200),
    status NVARCHAR(50) DEFAULT N'Đang hợp tác',
    contractStart DATE,
    contractEnd DATE
);
GO

-- Table: Report (Báo cáo)
CREATE TABLE Report (
    reportId VARCHAR(15) PRIMARY KEY,
    title NVARCHAR(200) NOT NULL,
    description NVARCHAR(1000),
    reportType NVARCHAR(50) DEFAULT N'Sự cố',
    createdAt DATETIME DEFAULT GETDATE(),
    createdBy VARCHAR(50),
    status NVARCHAR(50) DEFAULT N'Mới'
);
GO

-- ==========================================
-- Insert Default Admin Account
-- ==========================================
INSERT INTO Admin (adminId, username, password, fullName, email, avatarUrl) VALUES
('ADM001', 'superadmin', 'admin123', N'Quản trị viên', 'admin@hospital.vn', ''),
('ADM002', 'admin2', 'admin123', N'Phó Quản trị', 'admin2@hospital.vn', '');
GO

-- ==========================================
-- Insert Sample Appointments
-- ==========================================
INSERT INTO Appointment (appointmentId, patientId, doctorId, appointmentDate, appointmentTime, type, status, notes) VALUES
('APT001', 'BN001', 'BS001', '2026-04-08', '08:30', N'Khám thường', N'Đã xác nhận', N'Tái khám sau 2 tuần'),
('APT002', 'BN002', 'BS001', '2026-04-08', '09:15', N'Khám thường', N'Chờ xác nhận', N''),
('APT003', 'BN003', 'BS002', '2026-04-08', '10:00', N'Khám chuyên khoa', N'Đã xác nhận', N'Cần xét nghiệm máu'),
('APT004', 'BN004', 'BS001', '2026-04-08', '10:45', N'Khám thường', N'Đã hoàn thành', N''),
('APT005', 'BN001', 'BS002', '2026-04-09', '14:00', N'Tái khám', N'Chờ xác nhận', N'');
GO

-- ==========================================
-- Insert Sample Revenue
-- ==========================================
INSERT INTO Revenue (revenueId, amount, description, revenueDate, category, patientId) VALUES
('REV001', 250000, N'Phí khám bệnh - BN001', '2026-04-08', N'Khám bệnh', 'BN001'),
('REV002', 180000, N'Phí khám bệnh - BN002', '2026-04-08', N'Khám bệnh', 'BN002'),
('REV003', 450000, N'Xét nghiệm máu - BN003',  '2026-04-08', N'Xét nghiệm', 'BN003'),
('REV004', 320000, N'Phí khám bệnh - BN004', '2026-04-08', N'Khám bệnh', 'BN004'),
('REV005', 1200000, N'Thuốc điều trị - BN001', '2026-04-07', N'Dược phẩm', 'BN001'),
('REV006', 890000, N'Thuốc điều trị - BN003',  '2026-04-07', N'Dược phẩm', 'BN003'),
('REV007', 250000, N'Phí khám bệnh', '2026-04-06', N'Khám bệnh', 'BN002'),
('REV008', 560000, N'Siêu âm ổ bụng', '2026-04-06', N'Xét nghiệm', 'BN004');
GO

-- ==========================================
-- Insert Sample Partners
-- ==========================================
INSERT INTO Partner (partnerId, partnerName, partnerType, contactEmail, phone, address, status, contractStart, contractEnd) VALUES
('PTN001', N'Công ty Dược Phúc Thành', N'Dược phẩm', 'phucthanh@pharma.vn', '0281234567', N'123 Lê Lợi, Q1, TP.HCM', N'Đang hợp tác', '2024-01-01', '2027-01-01'),
('PTN002', N'Bệnh viện Chợ Rẫy', N'Liên kết', 'lienket@choray.vn', '02838554269', N'201B Nguyễn Chí Thanh, Q5', N'Đang hợp tác', '2023-06-01', '2026-06-01'),
('PTN003', N'Thiết bị Y tế Minh Khoa', N'Thiết bị', 'info@minhkhoa.vn', '0289876543', N'45 Đinh Tiên Hoàng, Bình Thạnh', N'Đang hợp tác', '2025-01-15', '2027-01-15'),
('PTN004', N'Bảo hiểm y tế ABC', N'Bảo hiểm', 'contact@abcinsure.vn', '19001234', N'Tòa nhà Vietcombank, Q3', N'Tạm dừng', '2022-03-01', '2025-03-01');
GO

-- ==========================================
-- Insert Sample Reports
-- ==========================================
INSERT INTO Report (reportId, title, description, reportType, createdAt, createdBy, status) VALUES
('RPT001', N'Máy điều hòa phòng 135 bị hỏng', N'Máy điều hòa phòng 135 không hoạt động từ sáng, bệnh nhân phản ánh nóng bức.', N'Sự cố', '2026-04-08 06:00:00', 'BS001', N'Mới'),
('RPT002', N'Thiếu thuốc Amoxicillin 500mg', N'Kho dược phẩm chỉ còn 85 hộp Amoxicillin, dưới mức tồn kho tối thiểu.', N'Kho dược', '2026-04-08 07:30:00', 'BS002', N'Đang xử lý'),
('RPT003', N'Vòi nước phòng vệ sinh tầng 2 bị rỉ', N'Cần thợ sửa chữa khẩn cấp, có nguy cơ trơn ngã.', N'Sự cố', '2026-04-07 15:00:00', 'BS001', N'Đã xử lý');
GO
