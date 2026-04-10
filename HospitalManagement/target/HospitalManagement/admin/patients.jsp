<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý bệnh nhân - Admin</title>
    <meta name="description" content="Quản lý danh sách bệnh nhân trong hệ thống bệnh viện CarePoint">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<div class="admin-layout">
    <jsp:include page="/includes/admin_sidebar.jsp" />

    <div class="admin-main">
        <div class="admin-topbar">
            <div class="topbar-left">
                <h1 data-i18n="nav_patients">Bệnh nhân</h1>
                <div class="breadcrumb">CarePoint / <span data-i18n="nav_patients">Bệnh nhân</span></div>
            </div>
            <div class="topbar-right">
                <button id="langToggleBtn" class="lang-toggle"><span class="lang-flag">🇻🇳</span><span class="lang-text">Tiếng Việt</span></button>
            </div>
        </div>

        <div class="admin-content">
            <div class="admin-table-container">
                <div class="admin-table-header">
                    <h2 data-i18n="nav_patients">Bệnh nhân</h2>
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
                <table class="admin-table" id="patientsTable">
                    <thead>
                        <tr>
                            <th data-i18n="th_id">Mã</th>
                            <th data-i18n="th_name">Họ tên</th>
                            <th data-i18n="th_diagnosis">Chuẩn đoán</th>
                            <th data-i18n="th_status">Trạng thái</th>
                            <th data-i18n="th_time">Giờ hẹn</th>
                            <th data-i18n="th_actions">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${patients}">
                            <tr>
                                <td><b>${p.patientId}</b></td>
                                <td>
                                    <div style="display:flex;align-items:center;gap:10px;">
                                        <div class="doc-avatar" style="background:linear-gradient(135deg,#05CD99,#4776E6);">${p.fullName.substring(0,1)}</div>
                                        <div>
                                            <div style="font-weight:600;color:#2B3674;">${p.fullName}</div>
                                            <div style="font-size:11px;color:#A3AED0;">${p.username}</div>
                                        </div>
                                    </div>
                                </td>
                                <td>${p.diagnosis}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.status == 'Đang điều trị'}"><span class="badge badge-blue">${p.status}</span></c:when>
                                        <c:when test="${p.status == 'Chờ khám'}"><span class="badge badge-yellow">${p.status}</span></c:when>
                                        <c:otherwise><span class="badge badge-green">${p.status}</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${p.appointmentTime}</td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn btn-edit btn-sm"
                                            onclick="openEditModal('${p.patientId}','${p.fullName}','${p.diagnosis}','${p.status}','${p.appointmentTime}')">✏️</button>
                                        <form method="post" action="${pageContext.request.contextPath}/admin/patients" style="display:inline;"
                                              onsubmit="return confirm('Xóa bệnh nhân này?')">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="patientId" value="${p.patientId}">
                                            <button type="submit" class="btn btn-danger btn-sm">🗑️</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty patients}">
                            <tr><td colspan="6" style="text-align:center;color:#A3AED0;padding:32px;" data-i18n="no_data">Không có dữ liệu</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Add -->
<div class="modal-backdrop" id="addModal">
    <div class="modal">
        <h3>➕ Thêm bệnh nhân</h3>
        <form method="post" action="${pageContext.request.contextPath}/admin/patients">
            <input type="hidden" name="action" value="add">
            <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;">
                <div class="form-group"><label>Mã BN</label><input name="patientId" required placeholder="BN005"></div>
                <div class="form-group"><label>Username</label><input name="username" required></div>
                <div class="form-group"><label>Mật khẩu</label><input name="password" value="123456"></div>
                <div class="form-group"><label>Giờ hẹn</label><input name="appointmentTime" type="time"></div>
            </div>
            <div class="form-group"><label>Họ tên</label><input name="fullName" required></div>
            <div class="form-group"><label>Chuẩn đoán</label><input name="diagnosis"></div>
            <div class="form-group"><label>Trạng thái</label>
                <select name="status">
                    <option value="Chờ khám">Chờ khám</option>
                    <option value="Đang điều trị">Đang điều trị</option>
                    <option value="Tái khám">Tái khám</option>
                </select>
            </div>
            <div class="modal-actions">
                <button type="button" class="btn btn-danger" onclick="closeModal('addModal')">Hủy</button>
                <button type="submit" class="btn btn-primary">Lưu</button>
            </div>
        </form>
    </div>
</div>

<!-- Edit -->
<div class="modal-backdrop" id="editModal">
    <div class="modal">
        <h3>✏️ Sửa bệnh nhân</h3>
        <form method="post" action="${pageContext.request.contextPath}/admin/patients">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="patientId" id="editId">
            <div class="form-group"><label>Họ tên</label><input name="fullName" id="editName" required></div>
            <div class="form-group"><label>Chuẩn đoán</label><input name="diagnosis" id="editDiagnosis"></div>
            <div class="form-group"><label>Trạng thái</label>
                <select name="status" id="editStatus">
                    <option value="Chờ khám">Chờ khám</option>
                    <option value="Đang điều trị">Đang điều trị</option>
                    <option value="Tái khám">Tái khám</option>
                </select>
            </div>
            <div class="form-group"><label>Giờ hẹn</label><input name="appointmentTime" id="editTime" type="time"></div>
            <div class="modal-actions">
                <button type="button" class="btn btn-danger" onclick="closeModal('editModal')">Hủy</button>
                <button type="submit" class="btn btn-primary">Lưu</button>
            </div>
        </form>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/i18n.js"></script>
<script>
function openAddModal() { document.getElementById('addModal').classList.add('open'); }
function closeModal(id) { document.getElementById(id).classList.remove('open'); }
function openEditModal(id, name, diag, status, time) {
    document.getElementById('editId').value = id;
    document.getElementById('editName').value = name;
    document.getElementById('editDiagnosis').value = diag;
    document.getElementById('editStatus').value = status;
    document.getElementById('editTime').value = time;
    document.getElementById('editModal').classList.add('open');
}
function filterTable() {
    const q = document.getElementById('searchInput').value.toLowerCase();
    document.querySelectorAll('#patientsTable tbody tr').forEach(r => {
        r.style.display = r.textContent.toLowerCase().includes(q) ? '' : 'none';
    });
}
</script>
</body>
</html>
