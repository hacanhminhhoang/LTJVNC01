<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Doanh thu - Admin</title>
    <meta name="description" content="Quản lý doanh thu bệnh viện CarePoint">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css">
</head>
<body>
<div class="admin-layout">
    <jsp:include page="/includes/admin_sidebar.jsp" />

    <div class="admin-main">
        <div class="admin-topbar">
            <div class="topbar-left">
                <h1 data-i18n="nav_revenue">Doanh thu</h1>
                <div class="breadcrumb">CarePoint / <span data-i18n="nav_revenue">Doanh thu</span></div>
            </div>
            <div class="topbar-right">
                <button id="langToggleBtn" class="lang-toggle"><span class="lang-flag">🇻🇳</span><span class="lang-text">Tiếng Việt</span></button>
            </div>
        </div>

        <div class="admin-content">
            <!-- Revenue Stats -->
            <div class="admin-stats-grid" style="grid-template-columns: repeat(3,1fr); margin-bottom: 24px;">
                <div class="admin-stat-card blue-card">
                    <div>
                        <div class="stat-label" data-i18n="revenue_total">Tổng doanh thu</div>
                        <div class="stat-number">
                            <fmt:formatNumber value="${totalRevenue != null ? totalRevenue : 0}" type="number" maxFractionDigits="0"/>đ
                        </div>
                        <div class="stat-trend up">↗ Tất cả thời gian</div>
                    </div>
                    <div class="stat-icon-box icon-bg-white">💰</div>
                </div>
                <div class="admin-stat-card">
                    <div>
                        <div class="stat-label" data-i18n="revenue_today">Doanh thu hôm nay</div>
                        <div class="stat-number">
                            <fmt:formatNumber value="${todayRevenue != null ? todayRevenue : 0}" type="number" maxFractionDigits="0"/>đ
                        </div>
                        <div class="stat-trend up">↗ Hôm nay</div>
                    </div>
                    <div class="stat-icon-box icon-bg-green">🏦</div>
                </div>
                <div class="admin-stat-card">
                    <div>
                        <div class="stat-label">Số giao dịch</div>
                        <div class="stat-number">${revenues != null ? revenues.size() : 0}</div>
                        <div class="stat-trend up">↗ Tổng cộng</div>
                    </div>
                    <div class="stat-icon-box icon-bg-purple">📊</div>
                </div>
            </div>

            <div class="admin-table-container">
                <div class="admin-table-header">
                    <h2 data-i18n="nav_revenue">Doanh thu</h2>
                    <div class="search-bar">
                        <span class="search-icon">🔍</span>
                        <input type="text" id="searchInput" placeholder="Tìm kiếm..." oninput="filterTable()">
                    </div>
                </div>
                <table class="admin-table" id="revenueTable">
                    <thead>
                        <tr>
                            <th data-i18n="th_id">Mã</th>
                            <th data-i18n="th_description">Mô tả</th>
                            <th data-i18n="th_category">Danh mục</th>
                            <th data-i18n="th_date">Ngày</th>
                            <th data-i18n="th_amount">Số tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="r" items="${revenues}">
                            <tr>
                                <td><b>${r.revenueId}</b></td>
                                <td>${r.description}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${r.category == 'Khám bệnh'}"><span class="badge badge-blue">${r.category}</span></c:when>
                                        <c:when test="${r.category == 'Dược phẩm'}"><span class="badge badge-green">${r.category}</span></c:when>
                                        <c:otherwise><span class="badge badge-purple">${r.category}</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${r.revenueDate}</td>
                                <td style="font-weight:700;color:#4776E6;">
                                    <fmt:formatNumber value="${r.amount}" type="number" maxFractionDigits="0"/>đ
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty revenues}">
                            <tr><td colspan="5" style="text-align:center;color:#A3AED0;padding:32px;" data-i18n="no_data">Không có dữ liệu</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/i18n.js"></script>
<script>
function filterTable() {
    const q = document.getElementById('searchInput').value.toLowerCase();
    document.querySelectorAll('#revenueTable tbody tr').forEach(r => {
        r.style.display = r.textContent.toLowerCase().includes(q) ? '' : 'none';
    });
}
</script>
</body>
</html>
