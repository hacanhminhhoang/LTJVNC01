<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String uri = request.getRequestURI();
    String ctx = request.getContextPath();
%>
<div class="admin-sidebar">
    <div class="admin-logo">
        <div class="logo-icon">🏥</div>
        <div class="logo-text">
            <h2>CarePoint</h2>
            <p>Admin Panel</p>
        </div>
    </div>

    <ul class="admin-nav">
        <li>
            <a href="${pageContext.request.contextPath}/admin/dashboard"
               class="<%= uri.contains("dashboard") ? "active" : "" %>">
                <span class="nav-icon">📊</span>
                <span data-i18n="nav_dashboard">Bảng điều khiển</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/doctors"
               class="<%= uri.contains("doctors") ? "active" : "" %>">
                <span class="nav-icon">👨‍⚕️</span>
                <span data-i18n="nav_doctors">Bác sĩ</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/department"
               class="<%= uri.contains("department") ? "active" : "" %>">
                <span class="nav-icon">🏢</span>
                <span data-i18n="nav_department">Khoa & Phòng</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/patients"
               class="<%= uri.contains("patients") ? "active" : "" %>">
                <span class="nav-icon">🏥</span>
                <span data-i18n="nav_patients">Bệnh nhân</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/appointments"
               class="<%= uri.contains("appointments") ? "active" : "" %>">
                <span class="nav-icon">📅</span>
                <span data-i18n="nav_appointments">Lịch hẹn</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/revenue"
               class="<%= uri.contains("revenue") ? "active" : "" %>">
                <span class="nav-icon">💰</span>
                <span data-i18n="nav_revenue">Doanh thu</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/reports"
               class="<%= uri.contains("reports") ? "active" : "" %>">
                <span class="nav-icon">📋</span>
                <span data-i18n="nav_reports">Báo cáo</span>
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/admin/partners"
               class="<%= uri.contains("partners") ? "active" : "" %>">
                <span class="nav-icon">🤝</span>
                <span data-i18n="nav_partners">Đối tác</span>
            </a>
        </li>
    </ul>

    <a href="${pageContext.request.contextPath}/logout" class="admin-logout">
        <span class="nav-icon">🚪</span>
        <span data-i18n="nav_logout">Đăng xuất</span>
    </a>
</div>
