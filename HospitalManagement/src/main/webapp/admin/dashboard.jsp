<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Quản lý bệnh viện</title>
    <meta name="description" content="Bảng điều khiển quản trị hệ thống bệnh viện CarePoint">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<div class="admin-layout">

    <!-- Sidebar -->
    <jsp:include page="/includes/admin_sidebar.jsp" />

    <!-- Main Area -->
    <div class="admin-main">

        <!-- Top Bar -->
        <div class="admin-topbar">
            <div class="topbar-left">
                <h1 data-i18n="nav_dashboard">Bảng điều khiển</h1>
                <div class="breadcrumb">CarePoint / <span data-i18n="nav_dashboard">Bảng điều khiển</span></div>
            </div>
            <div class="topbar-right">
                <!-- Language Toggle -->
                <button id="langToggleBtn" class="lang-toggle" title="Chuyển ngôn ngữ">
                    <span class="lang-flag">🇻🇳</span>
                    <span class="lang-text">Tiếng Việt</span>
                </button>
                <!-- Admin User -->
                <div class="admin-user">
                    <div class="admin-avatar">${admin != null ? admin.initials : 'A'}</div>
                    <div class="admin-user-info">
                        <div class="name">${admin != null ? admin.fullName : 'Admin'}</div>
                        <div class="role" data-i18n="admin_role">Quản trị viên</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Content -->
        <div class="admin-content">

            <!-- Stats Grid -->
            <div class="admin-stats-grid">
                <!-- Doctors stat -->
                <div class="admin-stat-card blue-card">
                    <div>
                        <div class="stat-label" data-i18n="total_doctors">Tổng bác sĩ</div>
                        <div class="stat-number">${totalDoctors != null ? totalDoctors : 0}</div>
                        <div class="stat-trend up">↗ 3 tham gia tuần này</div>
                    </div>
                    <div class="stat-icon-box icon-bg-white">👨‍⚕️</div>
                </div>

                <!-- Patients stat -->
                <div class="admin-stat-card">
                    <div>
                        <div class="stat-label" data-i18n="total_patients">Tổng bệnh nhân</div>
                        <div class="stat-number">${totalPatients != null ? totalPatients : 0}</div>
                        <div class="stat-trend up">↗ 1.3% so với tuần trước</div>
                    </div>
                    <div class="stat-icon-box icon-bg-green">🏥</div>
                </div>

                <!-- Revenue stat -->
                <div class="admin-stat-card">
                    <div>
                        <div class="stat-label" data-i18n="total_revenue">Tổng doanh thu</div>
                        <div class="stat-number">
                            <fmt:formatNumber value="${totalRevenue != null ? totalRevenue : 0}" type="number" maxFractionDigits="0"/>đ
                        </div>
                        <div class="stat-trend down">↘ 4.3% so với hôm qua</div>
                    </div>
                    <div class="stat-icon-box icon-bg-orange">💰</div>
                </div>

                <!-- Appointments stat -->
                <div class="admin-stat-card">
                    <div>
                        <div class="stat-label" data-i18n="total_appointments">Lịch hẹn</div>
                        <div class="stat-number">${totalAppointments != null ? totalAppointments : 0}</div>
                        <div class="stat-trend up">↗ 1.8% so với hôm qua</div>
                    </div>
                    <div class="stat-icon-box icon-bg-purple">📅</div>
                </div>
            </div>

            <!-- Dashboard Widgets Row 1 -->
            <div class="admin-grid" style="grid-template-columns: 2fr 1fr;">

                <!-- Appointments widget -->
                <div class="admin-widget">
                    <div class="widget-header">
                        <h3 data-i18n="appointments">Lịch hẹn</h3>
                        <a href="${pageContext.request.contextPath}/admin/appointments" class="widget-link" data-i18n="view_all">Xem tất cả</a>
                    </div>
                    <c:forEach var="a" items="${appointments}" end="4">
                        <div class="appt-item">
                            <div class="appt-avatar">👨‍⚕️</div>
                            <div class="appt-info">
                                <div class="doc-name">${a.doctorName}</div>
                                <div class="doc-spec">${a.doctorSpecialty}</div>
                            </div>
                            <div class="appt-time">
                                <div>Hôm nay</div>
                                <div class="time-val">${a.appointmentTimeStr}</div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty appointments}">
                        <div class="appt-item">
                            <div class="appt-avatar">👨‍⚕️</div>
                            <div class="appt-info">
                                <div class="doc-name">BS. Nguyễn Văn A</div>
                                <div class="doc-spec">Nội tổng khoa</div>
                            </div>
                            <div class="appt-time">
                                <div>Hôm nay</div>
                                <div class="time-val">08:30</div>
                            </div>
                        </div>
                    </c:if>
                </div>

                <!-- Reports widget -->
                <div class="admin-widget">
                    <div class="widget-header">
                        <h3 data-i18n="reports">Báo cáo</h3>
                        <a href="${pageContext.request.contextPath}/admin/reports" class="widget-link" data-i18n="view_all">Xem tất cả</a>
                    </div>
                    <c:forEach var="r" items="${reports}" end="2">
                        <div class="report-item">
                            <div class="report-icon">⚠️</div>
                            <div class="report-info">
                                <div class="report-title">${r.title}</div>
                                <div class="report-time">${r.timeAgo}</div>
                                <a href="${pageContext.request.contextPath}/admin/reports" class="report-link">Xem báo cáo →</a>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty reports}">
                        <div class="report-item">
                            <div class="report-icon">⚠️</div>
                            <div class="report-info">
                                <div class="report-title">Máy điều hòa phòng 135 bị hỏng</div>
                                <div class="report-time">1 phút trước</div>
                                <a href="#" class="report-link">Xem báo cáo →</a>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Revenue Chart + Donut Row -->
            <div class="admin-grid" style="grid-template-columns: 2fr 1fr;">

                <!-- Bar chart: Revenue by day (mock) -->
                <div class="admin-widget">
                    <div class="widget-header">
                        <h3 data-i18n="nav_revenue">Doanh thu</h3>
                        <a href="${pageContext.request.contextPath}/admin/revenue" class="widget-link" data-i18n="view_all">Xem tất cả</a>
                    </div>
                    <div style="display:flex; gap:6px; align-items:flex-end; height:180px; padding: 0 8px;">
                        <div style="flex:1; background:linear-gradient(180deg,#4776E6,#8E54E9); border-radius:6px 6px 0 0; height:60%;" title="Thứ 2"></div>
                        <div style="flex:1; background:linear-gradient(180deg,#4776E6,#8E54E9); border-radius:6px 6px 0 0; height:80%;" title="Thứ 3"></div>
                        <div style="flex:1; background:linear-gradient(180deg,#4776E6,#8E54E9); border-radius:6px 6px 0 0; height:50%;" title="Thứ 4"></div>
                        <div style="flex:1; background:linear-gradient(180deg,#4776E6,#8E54E9); border-radius:6px 6px 0 0; height:90%;" title="Thứ 5"></div>
                        <div style="flex:1; background:linear-gradient(180deg,#4776E6,#8E54E9); border-radius:6px 6px 0 0; height:70%;" title="Thứ 6"></div>
                        <div style="flex:1; background:linear-gradient(180deg, #E2E8F0, #E2E8F0); border-radius:6px 6px 0 0; height:40%;" title="Thứ 7"></div>
                        <div style="flex:1; background:linear-gradient(180deg, #E2E8F0, #E2E8F0); border-radius:6px 6px 0 0; height:30%;" title="CN"></div>
                    </div>
                    <div style="display:flex; justify-content:space-around; margin-top:8px; font-size:11px; color:#A3AED0;">
                        <span>T2</span><span>T3</span><span>T4</span><span>T5</span><span>T6</span><span>T7</span><span>CN</span>
                    </div>
                </div>

                <!-- Donut: Dept distribution (mock) -->
                <div class="admin-widget">
                    <div class="widget-header">
                        <h3>Khoa phổ biến</h3>
                    </div>
                    <div style="text-align:center;">
                        <svg width="120" height="120" viewBox="0 0 120 120">
                            <circle cx="60" cy="60" r="45" fill="none" stroke="#4776E6" stroke-width="18" stroke-dasharray="169 113" stroke-dashoffset="0" transform="rotate(-90 60 60)"/>
                            <circle cx="60" cy="60" r="45" fill="none" stroke="#8E54E9" stroke-width="18" stroke-dasharray="85 197" stroke-dashoffset="-169" transform="rotate(-90 60 60)"/>
                            <circle cx="60" cy="60" r="45" fill="none" stroke="#05CD99" stroke-width="18" stroke-dasharray="28 254" stroke-dashoffset="-254" transform="rotate(-90 60 60)"/>
                        </svg>
                    </div>
                    <div class="donut-legend">
                        <div class="legend-item"><div class="legend-dot" style="background:#4776E6;"></div>60% Tim mạch</div>
                        <div class="legend-item"><div class="legend-dot" style="background:#8E54E9;"></div>30% Nội thần kinh</div>
                        <div class="legend-item"><div class="legend-dot" style="background:#05CD99;"></div>10% Da liễu</div>
                    </div>
                </div>
            </div>

        </div><!-- /admin-content -->
    </div><!-- /admin-main -->
</div><!-- /admin-layout -->

<script src="${pageContext.request.contextPath}/js/i18n.js"></script>
</body>
</html>
