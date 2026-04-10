<%@ page pageEncoding="UTF-8" %>
<div class="sidebar">
    <div class="sidebar-logo">
        <div class="icon-box">🏥</div>
        <div>
            <h2>Bệnh Viện</h2>
            <p>Nhân viên Y tế</p>
        </div>
    </div>
    
    <ul class="nav-menu">
        <li>
            <a href="${pageContext.request.contextPath}/overview" class="nav-item <%= request.getRequestURI().contains("overview") ? "active" : "" %>">
                📊 Tổng Quan
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/pharmacy" class="nav-item <%= request.getRequestURI().contains("pharmacy") ? "active" : "" %>">
                📦 Kho Dược Phẩm
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/diagnosis" class="nav-item <%= request.getRequestURI().contains("diagnosis") ? "active" : "" %>">
                🩺 Chuẩn Đoán
            </a>
        </li>
    </ul>

    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
        🚪 Đăng Xuất
    </a>
</div>
