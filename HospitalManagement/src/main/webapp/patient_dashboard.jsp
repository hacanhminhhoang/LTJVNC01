<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cổng Bệnh Nhân - Quản Lý Bệnh Viện</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .sidebar { background: linear-gradient(180deg, #0f2b5b 0%, #1a3f7a 100%); }
        .sidebar-logo div h2 { color: #fff; }
        .sidebar-logo div p  { color: #94b8e8; }
        .nav-item { color: #94b8e8; }
        .nav-item:hover, .nav-item.active { background: rgba(255,255,255,0.12); color: #fff; }
        .logout-btn { color: #94b8e8; }

        .info-card { background: white; border-radius: 20px; padding: 28px; box-shadow: 0 4px 15px rgba(0,0,0,0.04); margin-bottom: 24px; }
        .info-card h3 { font-size: 16px; color: var(--text-muted); margin-bottom: 20px; font-weight: 600; letter-spacing:.5px; text-transform: uppercase; }

        .info-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 16px; }
        .info-item label { display: block; font-size: 12px; text-transform: uppercase; color: var(--text-muted); margin-bottom: 4px; }
        .info-item span  { font-size: 15px; font-weight: 600; color: var(--text-main); }

        .hero { background: linear-gradient(135deg, #2B6AFF 0%, #1a4fd6 100%);
                border-radius: 24px; padding: 32px; color: white; margin-bottom: 28px;
                display: flex; justify-content: space-between; align-items: center; }
        .hero h1 { font-size: 26px; margin-bottom: 6px; }
        .hero p  { opacity: .85; font-size: 14px; }
        .hero-icon { font-size: 64px; opacity: .4; }

        .status-badge { display: inline-block; padding: 6px 16px; border-radius: 20px; font-size: 13px; font-weight: 600; }
        .s-green  { background: #E6FBD9; color: #05CD99; }
        .s-blue   { background: #E8F0FF; color: #2B6AFF; }
        .s-yellow { background: #FFF8D6; color: #EAB308; }
    </style>
</head>
<body>

    <!-- Sidebar dành riêng bệnh nhân -->
    <div class="sidebar">
        <div class="sidebar-logo">
            <div class="icon-box" style="background:rgba(255,255,255,0.18);">🏥</div>
            <div>
                <h2>Bệnh Viện</h2>
                <p>Cổng Bệnh Nhân</p>
            </div>
        </div>

        <ul class="nav-menu">
            <li><a href="${pageContext.request.contextPath}/patient-dashboard" class="nav-item active">
                🏠 Thông Tin Của Tôi
            </a></li>
        </ul>

        <a href="${pageContext.request.contextPath}/logout" class="logout-btn" style="margin-top:auto; text-decoration:none; display:flex; align-items:center; gap:12px; padding:14px 20px;">
            🚪 Đăng Xuất
        </a>
    </div>

    <!-- Nội dung chính -->
    <div class="main-content">

        <!-- Hero banner -->
        <div class="hero">
            <div>
                <h1>Xin chào, ${patient.fullName}! 👋</h1>
                <p>Chào mừng bạn đến với Cổng Bệnh Nhân. Dưới đây là thông tin sức khỏe của bạn.</p>
            </div>
            <div class="hero-icon">🩺</div>
        </div>

        <!-- Thống kê nhanh -->
        <div class="stats-grid" style="grid-template-columns: repeat(3,1fr); max-width: 700px; margin-bottom: 28px;">
            <div class="stat-card">
                <div class="stat-info">
                    <h3>Mã Bệnh Nhân</h3>
                    <h2 style="font-size:20px;">${patient.patientId}</h2>
                </div>
                <div class="stat-icon bg-blue">🪪</div>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <h3>Trạng Thái</h3>
                    <h2 style="font-size:16px; margin-top:6px;">
                        <span class="status-badge
                            ${patient.status == 'Đang điều trị' ? 's-blue' :
                              patient.status == 'Tái khám' ? 's-green' : 's-yellow'}">
                            ${patient.status}
                        </span>
                    </h2>
                </div>
                <div class="stat-icon bg-green">💊</div>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <h3>Giờ Hẹn Khám</h3>
                    <h2 style="font-size:20px;">${fn:substring(patient.appointmentTime, 0, 5)}</h2>
                </div>
                <div class="stat-icon bg-purple">🕐</div>
            </div>
        </div>

        <!-- Thông tin chi tiết -->
        <div class="info-card">
            <h3>Thông Tin Cá Nhân</h3>
            <div class="info-grid">
                <div class="info-item">
                    <label>Họ và tên</label>
                    <span>${patient.fullName}</span>
                </div>
                <div class="info-item">
                    <label>Mã bệnh nhân</label>
                    <span>${patient.patientId}</span>
                </div>
                <div class="info-item">
                    <label>Tên đăng nhập</label>
                    <span>${patient.username}</span>
                </div>
                <div class="info-item">
                    <label>Trạng thái hiện tại</label>
                    <span>
                        <span class="status-badge
                            ${patient.status == 'Đang điều trị' ? 's-blue' :
                              patient.status == 'Tái khám' ? 's-green' : 's-yellow'}">
                            ${patient.status}
                        </span>
                    </span>
                </div>
            </div>
        </div>

        <!-- Thông tin khám bệnh -->
        <div class="info-card">
            <h3>Thông Tin Khám Bệnh</h3>
            <div class="info-grid">
                <div class="info-item">
                    <label>Chuẩn đoán bệnh</label>
                    <span>${empty patient.diagnosis ? 'Chưa có thông tin' : patient.diagnosis}</span>
                </div>
                <div class="info-item">
                    <label>Giờ hẹn khám</label>
                    <span>${fn:substring(patient.appointmentTime, 0, 5)}</span>
                </div>
            </div>
        </div>

        <p style="text-align:center; color:var(--text-muted); font-size:13px; margin-top:20px;">
            Để cập nhật thông tin hoặc xem đơn thuốc, vui lòng liên hệ bác sĩ phụ trách.
        </p>
    </div>

</body>
</html>
