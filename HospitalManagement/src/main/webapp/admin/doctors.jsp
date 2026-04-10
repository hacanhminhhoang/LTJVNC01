<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý bác sĩ - Admin</title>
    <meta name="description" content="Quản lý danh sách bác sĩ trong hệ thống bệnh viện CarePoint">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<div class="admin-layout">
    <jsp:include page="/includes/admin_sidebar.jsp" />

    <div class="admin-main">
        <div class="admin-topbar">
            <div class="topbar-left">
                <h1 data-i18n="nav_doctors">Bác sĩ</h1>
                <div class="breadcrumb">CarePoint / <span data-i18n="nav_doctors">Bác sĩ</span></div>
            </div>
            <div class="topbar-right">
                <button id="langToggleBtn" class="lang-toggle"><span class="lang-flag">🇻🇳</span><span class="lang-text">Tiếng Việt</span></button>
            </div>
        </div>

        <div class="admin-content">
            <div class="admin-table-container">
                <div class="admin-table-header">
                    <h2 data-i18n="nav_doctors">Bác sĩ</h2>
                    <div style="display:flex;gap:12px;align-items:center;">
                        <div class="search-bar">
                            <span class="search-icon">🔍</span>
                            <input type="text" id="searchInput" data-i18n-placeholder="search" placeholder="Tìm kiếm..." oninput="filterTable()">
                        </div>
                        <button class="btn btn-primary" onclick="openAddModal()">
                            ➕ <span data-i18n="btn_add">Thêm mới</span>
                        </button>
                    </div>
                </div>

                <table class="admin-table" id="doctorsTable">
                    <thead>
                        <tr>
                            <th data-i18n="th_id">Mã</th>
                            <th data-i18n="th_name">Họ tên</th>
                            <th data-i18n="th_specialty">Chuyên khoa</th>
                            <th data-i18n="th_status">Trạng thái</th>
                            <th data-i18n="th_phone">Số điện thoại</th>
                            <th data-i18n="th_actions">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="d" items="${doctors}">
                            <tr>
                                <td><b>${d.doctorId}</b></td>
                                <td>
                                    <div style="display:flex;align-items:center;gap:10px;">
                                        <div class="doc-avatar">${d.fullName.substring(0,1)}</div>
                                        <div>
                                            <div style="font-weight:600;color:#2B3674;">${d.fullName}</div>
                                            <div style="font-size:11px;color:#A3AED0;">${d.username}</div>
                                        </div>
                                    </div>
                                </td>
                                <td>${d.specialty}</td>
                                <td>
                                    <span class="badge ${d.status == 'Đang làm việc' ? 'badge-green' : 'badge-yellow'}">
                                        ${d.status}
                                    </span>
                                </td>
                                <td>${d.phoneNumber}</td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn btn-edit btn-sm" onclick="openEditModal('${d.doctorId}','${d.fullName}','${d.specialty}','${d.status}','${d.phoneNumber}')">
                                            ✏️
                                        </button>
                                        <form method="post" accept-charset="UTF-8" action="${pageContext.request.contextPath}/admin/doctors" style="display:inline;"
                                              onsubmit="return confirm('Xóa bác sĩ này?')">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="doctorId" value="${d.doctorId}">
                                            <button type="submit" class="btn btn-danger btn-sm">🗑️</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty doctors}">
                            <tr><td colspan="6" style="text-align:center;color:#A3AED0;padding:32px;" data-i18n="no_data">Không có dữ liệu</td></tr>
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
        <h3>➕ <span data-i18n="btn_add">Thêm bác sĩ</span></h3>
        <form method="post" accept-charset="UTF-8" action="${pageContext.request.contextPath}/admin/doctors">
            <input type="hidden" name="action" value="add">
            <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;">
                <div class="form-group"><label>Mã BS</label><input name="doctorId" required placeholder="BS003"></div>
                <div class="form-group"><label>Username</label><input name="username" required></div>
                <div class="form-group"><label>Mật khẩu</label><input name="password" type="password" required value="123456"></div>
                <div class="form-group"><label>Số điện thoại</label><input name="phoneNumber"></div>
            </div>
            <div class="form-group"><label>Họ tên</label><input name="fullName" required></div>
            <div class="form-group"><label>Chuyên khoa</label><input name="specialty" placeholder="Nội tổng khoa"></div>
            <div class="form-group"><label>Trạng thái</label>
                <select name="status">
                    <option value="Đang làm việc">Đang làm việc</option>
                    <option value="Nghỉ phép">Nghỉ phép</option>
                </select>
            </div>
            <div class="modal-actions">
                <button type="button" class="btn btn-danger" onclick="closeModal('addModal')" data-i18n="btn_cancel">Hủy</button>
                <button type="submit" class="btn btn-primary" data-i18n="btn_save">Lưu</button>
            </div>
        </form>
    </div>
</div>

<!-- Edit Modal -->
<div class="modal-backdrop" id="editModal">
    <div class="modal">
        <h3>✏️ <span data-i18n="btn_edit">Sửa bác sĩ</span></h3>
        <form method="post" accept-charset="UTF-8" action="${pageContext.request.contextPath}/admin/doctors">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="doctorId" id="editId">
            <div class="form-group"><label>Họ tên</label><input name="fullName" id="editName" required></div>
            <div class="form-group"><label>Chuyên khoa</label><input name="specialty" id="editSpecialty"></div>
            <div class="form-group"><label>Trạng thái</label>
                <select name="status" id="editStatus">
                    <option value="Đang làm việc">Đang làm việc</option>
                    <option value="Nghỉ phép">Nghỉ phép</option>
                </select>
            </div>
            <div class="form-group"><label>Số điện thoại</label><input name="phoneNumber" id="editPhone"></div>
            <div class="modal-actions">
                <button type="button" class="btn btn-danger" onclick="closeModal('editModal')" data-i18n="btn_cancel">Hủy</button>
                <button type="submit" class="btn btn-primary" data-i18n="btn_save">Lưu</button>
            </div>
        </form>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/i18n.js"></script>
<script>
function openAddModal() { document.getElementById('addModal').classList.add('open'); }
function closeModal(id) { document.getElementById(id).classList.remove('open'); }
function openEditModal(id, name, spec, status, phone) {
    document.getElementById('editId').value = id;
    document.getElementById('editName').value = name;
    document.getElementById('editSpecialty').value = spec;
    document.getElementById('editStatus').value = status;
    document.getElementById('editPhone').value = phone;
    document.getElementById('editModal').classList.add('open');
}
function filterTable() {
    const q = document.getElementById('searchInput').value.toLowerCase();
    document.querySelectorAll('#doctorsTable tbody tr').forEach(row => {
        row.style.display = row.textContent.toLowerCase().includes(q) ? '' : 'none';
    });
}
</script>
</body>
</html>
