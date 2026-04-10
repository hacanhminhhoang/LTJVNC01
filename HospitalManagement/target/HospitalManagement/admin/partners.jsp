<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đối tác - Admin</title>
    <meta name="description" content="Quản lý đối tác bệnh viện CarePoint">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<div class="admin-layout">
    <jsp:include page="/includes/admin_sidebar.jsp" />

    <div class="admin-main">
        <div class="admin-topbar">
            <div class="topbar-left">
                <h1 data-i18n="nav_partners">Đối tác</h1>
                <div class="breadcrumb">CarePoint / <span data-i18n="nav_partners">Đối tác</span></div>
            </div>
            <div class="topbar-right">
                <button id="langToggleBtn" class="lang-toggle"><span class="lang-flag">🇻🇳</span><span class="lang-text">Tiếng Việt</span></button>
            </div>
        </div>

        <div class="admin-content">
            <div class="admin-table-container">
                <div class="admin-table-header">
                    <h2 data-i18n="nav_partners">Đối tác</h2>
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
                <table class="admin-table" id="partnerTable">
                    <thead>
                        <tr>
                            <th data-i18n="th_id">Mã</th>
                            <th data-i18n="th_partner_name">Tên đối tác</th>
                            <th data-i18n="th_partner_type">Loại</th>
                            <th data-i18n="th_email">Email</th>
                            <th data-i18n="th_phone">Điện thoại</th>
                            <th data-i18n="th_status">Trạng thái</th>
                            <th data-i18n="th_contract">Hợp đồng</th>
                            <th data-i18n="th_actions">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${partners}">
                            <tr>
                                <td><b>${p.partnerId}</b></td>
                                <td>
                                    <div style="font-weight:600;color:#2B3674;">${p.partnerName}</div>
                                    <div style="font-size:11px;color:#A3AED0;">${p.address}</div>
                                </td>
                                <td><span class="badge badge-purple">${p.partnerType}</span></td>
                                <td style="font-size:13px;">${p.contactEmail}</td>
                                <td>${p.phone}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.status == 'Đang hợp tác'}"><span class="badge badge-green">${p.status}</span></c:when>
                                        <c:otherwise><span class="badge badge-gray">${p.status}</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="font-size:12px;color:#A3AED0;">${p.contractStart} → ${p.contractEnd}</td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="btn btn-edit btn-sm"
                                            onclick="openEditModal('${p.partnerId}','${p.partnerName}','${p.partnerType}','${p.contactEmail}','${p.phone}','${p.address}','${p.status}')">✏️</button>
                                        <form method="post" action="${pageContext.request.contextPath}/admin/partners" style="display:inline;"
                                              onsubmit="return confirm('Xóa đối tác này?')">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="partnerId" value="${p.partnerId}">
                                            <button type="submit" class="btn btn-danger btn-sm">🗑️</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty partners}">
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
        <h3>🤝 Thêm đối tác</h3>
        <form method="post" action="${pageContext.request.contextPath}/admin/partners">
            <input type="hidden" name="action" value="add">
            <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;">
                <div class="form-group"><label>Mã đối tác</label><input name="partnerId" required placeholder="PTN005"></div>
                <div class="form-group"><label>Loại</label>
                    <select name="partnerType">
                        <option value="Dược phẩm">Dược phẩm</option>
                        <option value="Thiết bị">Thiết bị</option>
                        <option value="Liên kết">Liên kết</option>
                        <option value="Bảo hiểm">Bảo hiểm</option>
                    </select>
                </div>
            </div>
            <div class="form-group"><label>Tên đối tác</label><input name="partnerName" required></div>
            <div style="display:grid;grid-template-columns:1fr 1fr;gap:12px;">
                <div class="form-group"><label>Email</label><input name="contactEmail" type="email"></div>
                <div class="form-group"><label>Điện thoại</label><input name="phone"></div>
                <div class="form-group"><label>Ngày bắt đầu HĐ</label><input name="contractStart" type="date"></div>
                <div class="form-group"><label>Ngày kết thúc HĐ</label><input name="contractEnd" type="date"></div>
            </div>
            <div class="form-group"><label>Địa chỉ</label><input name="address"></div>
            <div class="form-group"><label>Trạng thái</label>
                <select name="status">
                    <option value="Đang hợp tác">Đang hợp tác</option>
                    <option value="Tạm dừng">Tạm dừng</option>
                    <option value="Đã kết thúc">Đã kết thúc</option>
                </select>
            </div>
            <div class="modal-actions">
                <button type="button" class="btn btn-danger" onclick="closeModal('addModal')">Hủy</button>
                <button type="submit" class="btn btn-primary">Lưu</button>
            </div>
        </form>
    </div>
</div>

<!-- Edit Modal -->
<div class="modal-backdrop" id="editModal">
    <div class="modal">
        <h3>✏️ Sửa đối tác</h3>
        <form method="post" action="${pageContext.request.contextPath}/admin/partners">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="partnerId" id="editId">
            <div class="form-group"><label>Tên đối tác</label><input name="partnerName" id="editName" required></div>
            <div class="form-group"><label>Loại</label>
                <select name="partnerType" id="editType">
                    <option value="Dược phẩm">Dược phẩm</option>
                    <option value="Thiết bị">Thiết bị</option>
                    <option value="Liên kết">Liên kết</option>
                    <option value="Bảo hiểm">Bảo hiểm</option>
                </select>
            </div>
            <div class="form-group"><label>Email</label><input name="contactEmail" id="editEmail" type="email"></div>
            <div class="form-group"><label>Điện thoại</label><input name="phone" id="editPhone"></div>
            <div class="form-group"><label>Địa chỉ</label><input name="address" id="editAddress"></div>
            <div class="form-group"><label>Trạng thái</label>
                <select name="status" id="editStatus">
                    <option value="Đang hợp tác">Đang hợp tác</option>
                    <option value="Tạm dừng">Tạm dừng</option>
                    <option value="Đã kết thúc">Đã kết thúc</option>
                </select>
            </div>
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
function openEditModal(id, name, type, email, phone, addr, status) {
    document.getElementById('editId').value = id;
    document.getElementById('editName').value = name;
    document.getElementById('editType').value = type;
    document.getElementById('editEmail').value = email;
    document.getElementById('editPhone').value = phone;
    document.getElementById('editAddress').value = addr;
    document.getElementById('editStatus').value = status;
    document.getElementById('editModal').classList.add('open');
}
function filterTable() {
    const q = document.getElementById('searchInput').value.toLowerCase();
    document.querySelectorAll('#partnerTable tbody tr').forEach(r => {
        r.style.display = r.textContent.toLowerCase().includes(q) ? '' : 'none';
    });
}
</script>
</body>
</html>
