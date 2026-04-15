<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Tổng Quan - Quản lý bệnh viện</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>

    <jsp:include page="includes/sidebar.jsp" />

    <div class="main-content">
        <div class="page-header">
            <div>
                <h1>Tổng Quan</h1>
                <p>Chào mừng trở lại, Dr. Nguyễn</p>
            </div>
            <div class="user-profile">
                <span>Thứ Ba, 07 Tháng 4, 2026<br><b>Ca làm việc: Sáng</b></span>
                <div class="avatar">DN</div>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-info">
                    <h3>Bệnh Nhân Hôm Nay</h3>
                    <h2>${totalPatients != null ? totalPatients : 128}</h2>
                    <span class="trend up">+12% so với tháng trước</span>
                </div>
                <div class="stat-icon bg-blue">👥</div>
            </div>
            
            <div class="stat-card">
                <div class="stat-info">
                    <h3>Đơn Thuốc</h3>
                    <h2>${prescriptions != null ? prescriptions : 85}</h2>
                    <span class="trend up">+8% so với tháng trước</span>
                </div>
                <div class="stat-icon bg-green">💊</div>
            </div>

            <div class="stat-card">
                <div class="stat-info">
                    <h3>Lịch Hẹn</h3>
                    <h2>${appointments != null ? appointments : 42}</h2>
                    <span class="trend down">-3% so với tháng trước</span>
                </div>
                <div class="stat-icon bg-purple">📅</div>
            </div>

            <div class="stat-card">
                <div class="stat-info">
                    <h3>Tỷ Lệ Hồi Phục</h3>
                    <h2>${recoveryRate != null ? recoveryRate : "94%"}</h2>
                    <span class="trend up">+2% so với tháng trước</span>
                </div>
                <div class="stat-icon bg-orange">📈</div>
            </div>
        </div>

        <div class="table-container">
            <div class="table-header">
                <h2>Bệnh Nhân Gần Đây</h2>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>MÃ BN</th>
                        <th>HỌ TÊN</th>
                        <th>CHUẨN ĐOÁN</th>
                        <th>TRẠNG THÁI</th>
                        <th>GIỜ</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${patients}">
                        <tr>
                            <td><b>${p.patientId}</b></td>
                            <td>${p.fullName}</td>
                            <td>${p.diagnosis}</td>
                            <td>
                                <span class="badge ${p.status == 'Đang điều trị' ? 'badge-blue' : (p.status == 'Chờ khám' ? 'badge-yellow' : 'badge-green')}">
                                    ${p.status}
                                </span>
                            </td>
                            <td>${fn:substring(p.appointmentTime, 0, 5)}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty patients}">
                        <tr>
                            <td><b>BN001</b></td>
                            <td>Nguyễn Văn An</td>
                            <td>Cảm cúm</td>
                            <td><span class="badge badge-blue">Đang điều trị</span></td>
                            <td>08:30</td>
                        </tr>
                        <tr>
                            <td><b>BN002</b></td>
                            <td>Trần Thị Bình</td>
                            <td>Đau dạ dày</td>
                            <td><span class="badge badge-yellow">Chờ khám</span></td>
                            <td>09:15</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>
