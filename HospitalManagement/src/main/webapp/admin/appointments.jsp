<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lịch hẹn - Admin</title>
    <meta name="description" content="Quản lý lịch hẹn bệnh viện CarePoint">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<div class="admin-layout">
    <jsp:include page="/includes/admin_sidebar.jsp" />

    <div class="admin-main">
        <div class="admin-topbar">
            <div class="topbar-left">
                <h1 data-i18n="nav_appointments">Lịch hẹn</h1>
                <div class="breadcrumb">CarePoint / <span data-i18n="nav_appointments">Lịch hẹn</span></div>
            </div>
            <div class="topbar-right">
                <button id="langToggleBtn" class="lang-toggle"><span class="lang-flag">🇻🇳</span><span class="lang-text">Tiếng Việt</span></button>
            </div>
        </div>

        <div class="admin-content">
            <div class="admin-table-container">
                <div class="admin-table-header">
                    <h2 data-i18n="nav_appointments">Lịch hẹn</h2>
                    <div style="display:flex;gap:12px;align-items:center;">
                        <div class="search-bar">
                            <span class="search-icon">🔍</span>
                            <input type="text" id="searchInput" placeholder="Tìm kiếm..." oninput="filterTable()">
                        </div>
                        <button class="btn btn-primary" onclick="openAddModal()">
                            ➕ <span data-i18n="btn_add">Thêm mới</span>
                        </button>
                    </div>
                </div>
                <table class="admin-table" id="apptTable">
                    <thead>
                        <tr>
                            <th data-i18n="th_id">Mã</th>
                            <th data-i18n="th_patient">Bệnh nhân</th>
                            <th data-i18n="th_doctor">Bác sĩ</th>
                            <th data-i18n="th_date">Ngày</th>
                            <th data-i18n="th_time">Giờ</th>
                            <th data-i18n="th_type">Loại</th>
                            <th data-i18n="th_status">Trạng thái</th>
                            <th data-i18n="th_actions">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="a" items="${appointments}">
                            <tr>
                                <td><b>${a.appointmentId}</b></td>
                                <td>${a.patientName}</td>
                                <td>
                                    <div style="font-weight:600;">${a.doctorName}</div>
                                    <div style="font-size:11px;color:#A3AED0;">${a.doctorSpecialty}</div>
                                </td>
                                <td>${a.appointmentDate}</td>
                                <td><b>${a.appointmentTimeStr}</b></td>
                                <td><span class="badge badge-purple">${a.type}</span></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${a.status == 'Đã xác nhận'}"><span class="badge badge-green">${a.status}</span></c:when>
                                        <c:when test="${a.status == 'Chờ xác nhận'}"><span class="badge badge-yellow">${a.status}</span></c:when>
                                        <c:otherwise><span class="badge badge-blue">${a.status}</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="action-buttons">
                                        <form method="post" accept-charset="UTF-8" action="${pageContext.request.contextPath}/admin/appointments" style="display:inline;"
                                              onsubmit="return confirm('Xóa lịch hẹn này?')">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="appointmentId" value="${a.appointmentId}">
                                            <button type="submit" class="btn btn-danger btn-sm">🗑️</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty appointments}">
                            <tr><td colspan="8" style="text-align:center;color:#A3AED0;padding:32px;" data-i18n="no_data">Không có dữ liệu</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Add Modal -->
<div class="modal-backdrop" id="addModal">
    <div class="modal">
        <h3>➕ Thêm lịch hẹn</h3>
        <form method="post" accept-charset="UTF-8" action="${pageContext.request.contextPath}/admin/appointments">
            <input type="hidden" name="action" value="add">
            <div class="form-group"><label>Mã lịch hẹn</label><input name="appointmentId" required placeholder="APT006"></div>
            <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;">
                <div class="form-group"><label>Bệnh nhân</label>
                    <select name="patientId">
                        <c:forEach var="p" items="${patients}">
                            <option value="${p.patientId}">${p.fullName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group"><label>Bác sĩ</label>
                    <select name="doctorId">
                        <c:forEach var="d" items="${doctors}">
                            <option value="${d.doctorId}">${d.fullName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group"><label>Ngày</label><input name="appointmentDate" type="date" required></div>
                <div class="form-group"><label>Giờ</label><input name="appointmentTime" type="time" required></div>
            </div>
            <div class="form-group"><label>Loại khám</label>
                <select name="type">
                    <option value="Khám thường">Khám thường</option>
                    <option value="Khám chuyên khoa">Khám chuyên khoa</option>
                    <option value="Tái khám">Tái khám</option>
                </select>
            </div>
            <div class="form-group"><label>Trạng thái</label>
                <select name="status">
                    <option value="Chờ xác nhận">Chờ xác nhận</option>
                    <option value="Đã xác nhận">Đã xác nhận</option>
                </select>
            </div>
            <div class="form-group"><label>Ghi chú</label><textarea name="notes" rows="2"></textarea></div>
            <div class="modal-actions">
                <button type="button" class="btn btn-danger" onclick="closeModal('addModal')">Hủy</button>
                <button type="submit" class="btn btn-primary">Lưu</button>
            </div>
        </form>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/i18n.js"></script>
<script>
function openAddModal() { document.getElementById('addModal').classList.add('open'); }
function closeModal(id) { document.getElementById(id).classList.remove('open'); }
function filterTable() {
    const q = document.getElementById('searchInput').value.toLowerCase();
    document.querySelectorAll('#apptTable tbody tr').forEach(r => {
        r.style.display = r.textContent.toLowerCase().includes(q) ? '' : 'none';
    });
}
</script>
</body>
</html>
