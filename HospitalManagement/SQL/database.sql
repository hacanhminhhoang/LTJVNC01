CREATE DATABASE HospitalManagement;
GO

USE HospitalManagement;
GO

-- Table: Patient
CREATE TABLE Patient (
    patientId VARCHAR(10) PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(255),
    fullName NVARCHAR(100) NOT NULL,
    diagnosis NVARCHAR(200),
    status NVARCHAR(50) DEFAULT N'Chờ khám',
    appointmentTime TIME
);
GO

-- Table: Medicine (Kho Dược Phẩm)
CREATE TABLE Medicine (
    medicineId VARCHAR(10) PRIMARY KEY,
    name NVARCHAR(150) NOT NULL,
    category NVARCHAR(50) DEFAULT N'Thuốc', -- Thuốc, Vật tư
    quantity INT DEFAULT 0,
    price DECIMAL(18, 2) DEFAULT 0,
    expirationDate DATE
);
GO

-- Table: Doctor (Nhân viên Y tế)
CREATE TABLE Doctor (
    doctorId VARCHAR(10) PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    fullName NVARCHAR(100) NOT NULL,
    specialty NVARCHAR(100),
    status NVARCHAR(50) DEFAULT N'Đang làm việc', -- Đang làm việc, Nghỉ phép
    phoneNumber VARCHAR(15)
);
GO

-- Insert Sample Data
INSERT INTO Patient (patientId, username, password, fullName, diagnosis, status, appointmentTime) VALUES 
('BN001', 'benhnhan1', '123456', N'Nguyễn Văn An',   N'Cảm cúm',       N'Đang điều trị', '08:30'),
('BN002', 'benhnhan2', '123456', N'Trần Thị Bình',   N'Đau dạ dày',    N'Chờ khám',      '09:15'),
('BN003', 'benhnhan3', '123456', N'Lê Hoàng Cường',  N'Đái tháo đường',N'Tái khám',      '10:00'),
('BN004', 'benhnhan4', '123456', N'Phạm Thị Dung',   N'Cao huyết áp',  N'Đang điều trị', '10:45');

INSERT INTO Medicine (medicineId, name, category, quantity, price, expirationDate) VALUES
('DP001', N'Paracetamol 500mg', N'Thuốc', 1200, 500, '2026-12-01'),
('DP002', N'Amoxicillin 500mg', N'Thuốc', 85, 1200, '2026-08-01'),
('DP003', N'Vitamin C 1000mg', N'Thuốc', 800, 300, '2027-03-01'),
('VT001', N'Khẩu trang y tế', N'Vật tư', 200, 1000, '2028-01-01');

INSERT INTO Doctor (doctorId, username, password, fullName, specialty, status, phoneNumber) VALUES
('BS001', 'admin', '123456', N'BS. Nguyễn Văn A', N'Nội tổng khoa', N'Đang làm việc', '0901234567'),
('BS002', 'bacsi', '123456', N'BS. Trần Thị B', N'Nhi khoa', N'Nghỉ phép', '0909876543');
GO
