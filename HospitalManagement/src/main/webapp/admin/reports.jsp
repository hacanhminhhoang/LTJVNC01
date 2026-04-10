<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Báo cáo - Admin</title>
    <meta name="description" content="Quản lý báo cáo sự cố trong hệ thống bệnh viện CarePoint">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<div class="admin-layout">
    <jsp:include page="/includes/admin_sidebar.jsp" />

    <div class="admin-main">
        <div class="admin-topbar">
            <div class="topbar-left">
                <h1 data-i18n="nav_reports">Báo cáo</h1>
                <div class="breadcrumb">CarePoint / <span data-i18n="nav_reports">Báo cáo</span></div>
            </div>
            <div class="topbar-right">
                <button id="langToggleBtn" class="lang-toggle"><span class="lang-flag">🇻🇳</span><span class="lang-text">Tiếng Việt</span></button>
            </div>
        </div>

        <div class="admin-content">
            <div class="admin-table-container">
                <div class="admin-table-header">
                    <h2 data-i18n="nav_reports">Báo cáo sự cố</h2>
                    <button class="btn btn-primary" onclick="openAddModal()">➕ <span data-i18n="btn_add">Thêm mới</span></button>
                </div>

                <!-- Report cards -->
                <div style="display:flex;flex-direction:column;gap:12px;">
                    <c:forEach var="r" items="${reports}">
                        <div style="background:#FAFBFF;border:1px solid #E2E8F0;border-radius:14px;padding:18px 20px;display:flex;gap:14px;align-items:flex-start;">
                            <div style="width:42px;height:42px;background:#FFF3D6;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:20px;flex-shrink:0;">
                                <c:choose>
                                    <c:when test="${r.reportType == 'Sự cố'}">⚠️</c:when>
                                    <c:when test="${r.reportType == 'Kho dược'}">💊</c:when>
                                    <c:otherwise>📋</c:otherwise>
                                </c:choose>
                            </div>
                            <div style="flex:1;">
                                <div style="display:flex;justify-content:space-between;align-items:flex-start;">
                                    <div>
                                        <div style="font-weight:700;color:#2B3674;font-size:15px;">${r.title}</div>
                                        <div style="font-size:12px;color:#A3AED0;margin-top:3px;">${r.timeAgo} · ${r.createdBy}</div>
                                    </div>
                                    <div style="display:flex;gap:8px;align-items:center;">
                                        <c:choose>
                                            <c:when test="${r.status == 'Mới'}"><span class="badge badge-yellow">${r.status}</span></c:when>
                                            <c:when test="${r.status == 'Đang xử lý'}"><span class="badge badge-blue">${r.status}</span></c:when>
                                            <c:otherwise><span class="badge badge-green">${r.status}</span></c:otherwise>
                                        </c:choose>
                                        <form method="post" accept-charset="UTF-8" action="${pageContext.request.contextPath}/admin/reports" style="display:inline;">
                                            <input type="hidden" name="action" value="updateStatus">
                                            <input type="hidden" name="reportId" value="${r.reportId}">
                                            <select name="status" onchange="this.form.submit()" style="font-size:11px;border:1px solid #E2E8F0;border-radius:7px;padding:3px 6px;cursor:pointer;outline:none;">
                                                <option value="Mới" ${r.status == 'Mới' ? 'selected' : ''}>Mới</option>
                                                <option value="Đang xử lý" ${r.status == 'Đang xử lý' ? 'selected' : ''}>Đang xử lý</option>
                                                <option value="Đã xử lý" ${r.status == 'Đã xử lý' ? 'selected' : ''}>Đã xử lý</option>
                                            </select>
                                        </form>
                                    </div>
                                </div>
                                <div style="font-size:13px;color:#4A5568;margin-top:8px;line-height:1.5;">${r.description}</div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty reports}">
                        <div style="text-align:center;color:#A3AED0;padding:48px;" data-i18n="no_data">Không có dữ liệu</div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Add Report Modal -->
<div class="modal-backdrop" id="addModal">
    <div class="modal">
        <h3>➕ Tạo báo cáo mới</h3>
        <form method="post" accept-charset="UTF-8" action="${pageContext.request.contextPath}/admin/reports">
            <input type="hidden" name="action" value="add">
            <div class="form-group"><label>Mã báo cáo</label><input name="reportId" required placeholder="RPT004"></div>
            <div class="form-group"><label>Tiêu đề</label><input name="title" required></div>
            <div class="form-group"><label>Loại</label>
                <select name="reportType">
                    <option value="Sự cố">Sự cố</option>
                    <option value="Kho dược">Kho dược</option>
                    <option value="Khác">Khác</option>
                </select>
            </div>
            <div class="form-group"><label>Người tạo</label><input name="createdBy" placeholder="BS001"></div>
            <div class="form-group"><label>Mô tả</label><textarea name="description" rows="3"></textarea></div>
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
</script>
</body>
</html>
