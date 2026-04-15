<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Khoa Phòng - Quản lý bệnh viện</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .filter-bar { display: flex; gap: 16px; margin-bottom: 24px; padding: 0 24px; }
        .filter-bar select { padding: 10px 16px; border-radius: 8px; border: 1px solid #E2E8F0; background: white; outline:none; }
        .action-icon { cursor: pointer; color: #A3AED0; font-size: 18px; margin-right: 8px; }
        .action-icon:hover { color: #4776E6; }
        .action-icon.delete:hover { color: red; }

        .table-container { margin: 0 24px; background: white; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.02); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 16px 20px; text-align: left; border-bottom: 1px solid #F4F7FE; }
        th { font-weight: 600; color: #A3AED0; font-size: 12px; }
        .badge-blue { background: #E8F0FE; color: #4776E6; padding: 4px 10px; border-radius: 6px; font-size: 12px; font-weight: 600; }
        .btn-primary { background: #4776E6; color: white; border: none; padding: 10px 20px; border-radius: 8px; font-weight: 500; cursor: pointer; }
        .btn-secondary { background: white; color: #4776E6; border: 1px solid #4776E6; padding: 10px 20px; border-radius: 8px; font-weight: 500; cursor: pointer; }
    </style>
</head>
<body>

<div class="admin-layout">
    <!-- Reusing sidebar structure -->
    <jsp:include page="/includes/admin_sidebar.jsp" />

    <div class="admin-main">
        <div class="admin-topbar">
            <div class="topbar-left">
                <h1>Quản lý Khoa Phòng</h1>
                <div class="breadcrumb">Admin / Khoa Phòng</div>
            </div>
            <div class="topbar-right">
                <div class="admin-user">
                    <div class="admin-avatar">A</div>
                    <div class="admin-user-info">
                        <div class="name">Admin</div>
                        <div class="role">Quản trị viên</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="admin-content" style="padding: 24px 0;">
            <div style="display:flex; justify-content:space-between; align-items:center; margin: 0 24px 16px 24px;">
                <div>
                    <h2>Danh sách nhân sự</h2>
                </div>
                <div>
                    <button class="btn-secondary" onclick="openDeptModal()" style="margin-right: 12px;">+ Thêm Khoa</button>
                    <button class="btn-primary" onclick="openStaffModal()">+ Thêm Nhân Viên</button>
                </div>
            </div>

        <div class="filter-bar">
            <form action="${pageContext.request.contextPath}/admin/department" method="GET" style="display:flex; gap:16px; width:100%;">
                <select name="deptId" onchange="this.form.submit()">
                    <option value="">-- Tất cả các khoa --</option>
                    <c:forEach var="d" items="${departments}">
                        <option value="${d.departmentId}" ${selectedDept == d.departmentId ? 'selected' : ''}>${d.departmentName}</option>
                    </c:forEach>
                </select>
            </form>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>MÃ NV</th>
                        <th>HỌ TÊN</th>
                        <th>CHỨC VỤ</th>
                        <th>KHOA / PHÒNG</th>
                        <th>SỐ ĐIỆN THOẠI</th>
                        <th>HÀNH ĐỘNG</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="s" items="${staffs}">
                        <tr>
                            <td><b>${s.staffId}</b></td>
                            <td>${s.fullName}</td>
                            <td>${s.role}</td>
                            <td><span class="badge badge-blue">${s.departmentName}</span></td>
                            <td>${s.phoneNumber}</td>
                            <td>
                                <span class="action-icon" onclick="editStaff('${s.staffId}','${s.fullName}','${s.role}','${s.departmentId}','${s.phoneNumber}','${s.email}')">✏️</span>
                                <a href="${pageContext.request.contextPath}/admin/department?action=deleteStaff&id=${s.staffId}&deptId=${selectedDept}" class="action-icon delete" onclick="return confirm('Xóa nhân viên này?');">🗑️</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty staffs}">
                        <tr><td colspan="6" style="text-align: center; padding: 40px; color: #888;">Không có nhân viên nào trong khoa này.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
        </div>
    </div>
</div>

    <!-- Modal Thêm/Sửa Khoa -->
    <div class="modal-backdrop" id="deptModalBackdrop">
        <div class="modal">
            <h3 id="deptModalTitle">Thêm Khoa Mới</h3>
            <form action="${pageContext.request.contextPath}/admin/department" method="POST">
                <input type="hidden" name="action" id="deptAction" value="addDept">
                <div class="form-group">
                    <label>Mã Khoa</label>
                    <input type="text" name="departmentId" id="deptIdInput" required>
                </div>
                <div class="form-group">
                    <label>Tên Khoa</label>
                    <input type="text" name="departmentName" required>
                </div>
                <div class="form-group">
                    <label>Mô tả</label>
                    <input type="text" name="description">
                </div>
                <div class="modal-actions">
                    <button type="button" class="btn-secondary" onclick="closeModals()">Hủy</button>
                    <button type="submit" class="btn-primary">Lưu</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Modal Thêm/Sửa Nhân Viên -->
    <div class="modal-backdrop" id="staffModalBackdrop">
        <div class="modal">
            <h3 id="staffModalTitle">Thêm Nhân Viên</h3>
            <form action="${pageContext.request.contextPath}/admin/department" method="POST">
                <input type="hidden" name="action" id="staffAction" value="addStaff">
                <div class="form-group">
                    <label>Mã Nhân Viên</label>
                    <input type="text" name="staffId" id="staffIdInput" required>
                </div>
                <div class="form-group">
                    <label>Họ Tên</label>
                    <input type="text" name="fullName" id="staffFullName" required>
                </div>
                <div class="form-group">
                    <label>Chức vụ</label>
                    <input type="text" name="role" id="staffRole" placeholder="Ví dụ: Bác sĩ, Y tá..." required>
                </div>
                <div class="form-group">
                    <label>Khoa / Phòng</label>
                    <select name="departmentId" id="staffDept" required>
                        <c:forEach var="d" items="${departments}">
                            <option value="${d.departmentId}">${d.departmentName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>Số điện thoại</label>
                    <input type="text" name="phoneNumber" id="staffPhone">
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" id="staffEmail">
                </div>
                <div class="modal-actions">
                    <button type="button" class="btn-secondary" onclick="closeModals()">Hủy</button>
                    <button type="submit" class="btn-primary">Lưu</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function openDeptModal() {
            document.getElementById('deptModalTitle').innerText = 'Thêm Khoa Mới';
            document.getElementById('deptAction').value = 'addDept';
            document.getElementById('deptModalBackdrop').classList.add('open');
        }

        function openStaffModal() {
            document.getElementById('staffModalTitle').innerText = 'Thêm Nhân Viên';
            document.getElementById('staffAction').value = 'addStaff';
            document.getElementById('staffIdInput').readOnly = false;
            document.getElementById('staffModalBackdrop').classList.add('open');
        }

        function editStaff(id, name, role, deptId, phone, email) {
            document.getElementById('staffModalTitle').innerText = 'Sửa Nhân Viên';
            document.getElementById('staffAction').value = 'editStaff';
            document.getElementById('staffIdInput').value = id;
            document.getElementById('staffIdInput').readOnly = true;
            document.getElementById('staffFullName').value = name;
            document.getElementById('staffRole').value = role;
            document.getElementById('staffDept').value = deptId;
            document.getElementById('staffPhone').value = phone;
            document.getElementById('staffEmail').value = email;
            document.getElementById('staffModalBackdrop').classList.add('open');
        }

        function closeModals() {
            document.getElementById('deptModalBackdrop').classList.remove('open');
            document.getElementById('staffModalBackdrop').classList.remove('open');
        }
    </script>
</body>
</html>
