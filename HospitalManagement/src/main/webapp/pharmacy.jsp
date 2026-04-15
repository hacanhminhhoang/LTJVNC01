<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Kho Dược Phẩm - Quản lý bệnh viện</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .page-header-actions { display: flex; gap: 12px; }
        .btn-outline { background: white; border: 1px solid var(--border-color); padding: 12px 24px; border-radius: 12px; font-weight: 600; cursor: pointer; color: var(--text-main); transition: 0.2s; }
        .btn-outline:hover { border-color: var(--primary-blue); color: var(--primary-blue); }
        .stats-grid.pharmacy-grid { grid-template-columns: repeat(3, 1fr); max-width: 800px; margin-bottom: 24px; }
        .btn-filter { padding: 10px 20px; border-radius: 8px; cursor: pointer; font-weight: 600; font-size: 14px; transition: 0.2s; }
        .btn-filter.active { background-color: var(--primary-blue); color: white; border-color: var(--primary-blue); }
        .pagination { display: flex; justify-content: flex-end; align-items: center; gap: 8px; margin-top: 20px; padding-top: 16px; border-top: 1px solid var(--border-color); }
        .page-btn { width: 36px; height: 36px; display: flex; align-items: center; justify-content: center; border: 1px solid var(--border-color); border-radius: 8px; cursor: pointer; font-size: 14px; font-weight: 600; color: var(--text-muted); background: white; transition: 0.2s; }
        .page-btn:hover { border-color: var(--primary-blue); color: var(--primary-blue); }
        .page-btn.active { background-color: var(--primary-blue); color: white; border-color: var(--primary-blue); }
        .page-btn:disabled { opacity: 0.4; cursor: default; pointer-events: none; }
        .page-info { font-size: 13px; color: var(--text-muted); margin-right: 8px; }
    </style>
</head>
<body>

    <jsp:include page="includes/sidebar.jsp" />

    <div class="main-content">
        <div class="page-header">
            <div>
                <h1>Quản Lý Kho Dược Phẩm & Vật Tư</h1>
                <p>Theo dõi và quản lý tồn kho</p>
            </div>
            <div class="page-header-actions">
                <button class="btn-outline">📥 Xuất Excel</button>
                <button class="btn-primary">+ Thêm Mới</button>
            </div>
        </div>

        <div class="stats-grid pharmacy-grid">
            <div class="stat-card">
                <div class="stat-info">
                    <h3>Tổng Danh Mục</h3>
                    <h2 id="stat-total">—</h2>
                </div>
                <div class="stat-icon bg-blue">📦</div>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <h3>Sắp Hết Hàng</h3>
                    <h2 id="stat-low">—</h2>
                </div>
                <div class="stat-icon bg-orange">⚠️</div>
            </div>
            <div class="stat-card">
                <div class="stat-info">
                    <h3>Hết Hàng</h3>
                    <h2 id="stat-out">—</h2>
                </div>
                <div class="stat-icon" style="background-color: var(--danger-red);">📈</div>
            </div>
        </div>

        <div class="table-container">
            <div class="table-header" style="flex-direction: column; align-items: flex-start; gap: 16px;">
                <div style="display:flex; gap:16px; width:100%; align-items: center;">
                    <input type="text" id="searchInput"
                           placeholder="🔍 Tìm kiếm theo tên hoặc mã sản phẩm"
                           style="padding: 12px 16px; border: 1px solid #ddd; border-radius: 10px; width: 320px; outline:none; font-size:14px;">
                    <div style="display:flex; gap: 8px;" id="categoryFilters">
                        <button class="btn-outline btn-filter active" data-cat="Tất cả">Tất cả</button>
                        <button class="btn-outline btn-filter" data-cat="Thuốc">Thuốc</button>
                        <button class="btn-outline btn-filter" data-cat="Vật tư">Vật tư</button>
                    </div>
                    <span id="result-count" style="margin-left:auto; color:var(--text-muted); font-size:13px;"></span>
                </div>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>MÃ</th>
                        <th>TÊN SẢN PHẨM</th>
                        <th>DANH MỤC</th>
                        <th>SỐ LƯỢNG</th>
                        <th>ĐƠN VỊ</th>
                        <th>ĐƠN GIÁ</th>
                        <th>HSD</th>
                    </tr>
                </thead>
                <tbody id="tableBody">
                    <tr><td colspan="7" style="text-align:center; padding:24px; color:var(--text-muted);">Đang tải dữ liệu...</td></tr>
                </tbody>
            </table>
            <div class="pagination" id="pagination"></div>
        </div>
    </div>

    <script>
        // Lấy context path từ server-side JSP một lần duy nhất
        const CTX = '<%= request.getContextPath() %>';
        const PAGE_SIZE = 20;

        let allData = [];    // Toàn bộ dữ liệu từ server
        let filtered = [];  // Dữ liệu sau khi lọc/tìm kiếm
        let currentPage = 1;
        let currentCategory = 'Tất cả';

        const searchInput = document.getElementById('searchInput');
        const tableBody   = document.getElementById('tableBody');
        const pagination  = document.getElementById('pagination');
        const resultCount = document.getElementById('result-count');
        function fetchAll() {
            // Gọi với category rỗng để lấy TẤT CẢ sản phẩm
            fetch(CTX + '/api/pharmacy/search?q=&category=')
                .then(r => {
                    if (!r.ok) throw new Error('HTTP ' + r.status);
                    return r.json();
                })
                .then(data => {
                    allData = data;
                    // Cập nhật thẻ thống kê
                    document.getElementById('stat-total').textContent = data.length;
                    const lowStock  = data.filter(m => m.quantity > 0 && m.quantity <= 100).length;
                    const outStock  = data.filter(m => m.quantity === 0).length;
                    document.getElementById('stat-low').textContent  = lowStock;
                    document.getElementById('stat-out').textContent  = outStock;

                    applyFilter();
                })
                .catch(err => {
                    tableBody.innerHTML = '<tr><td colspan="7" style="text-align:center;color:red;padding:20px;">Lỗi kết nối: ' + err.message + '</td></tr>';
                });
        }

        // ── Lọc dữ liệu theo ô tìm kiếm + danh mục ──
        function applyFilter() {
            const q = searchInput.value.trim().toLowerCase();

            filtered = allData.filter(m => {
                const matchQ   = !q || m.name.toLowerCase().includes(q) || m.medicineId.toLowerCase().includes(q);
                const matchCat = currentCategory === 'Tất cả' || m.category === currentCategory;
                return matchQ && matchCat;
            });

            currentPage = 1;
            renderTable();
            renderPagination();
        }

        // ── Vẽ bảng cho trang hiện tại ──
        function renderTable() {
            const start = (currentPage - 1) * PAGE_SIZE;
            const end   = start + PAGE_SIZE;
            const pageData = filtered.slice(start, end);

            resultCount.textContent = 'Hiển thị ' + pageData.length + '/' + filtered.length + ' sản phẩm';

            if (pageData.length === 0) {
                tableBody.innerHTML = '<tr><td colspan="7" style="text-align:center;padding:24px;color:var(--text-muted);">Không tìm thấy sản phẩm nào</td></tr>';
                return;
            }

            tableBody.innerHTML = pageData.map(m => {
                // Đơn vị dựa theo danh mục
                const unit = (m.category === 'Thuốc') ? 'Viên' : 'Cái';
                const badgeCls = (m.category === 'Thuốc') ? 'badge-blue' : 'badge-green';

                // Format ngày HSD (YYYY-MM-DD → MM/YYYY)
                let hsd = m.expirationDate || '';
                if (hsd && hsd.length >= 7) {
                    hsd = hsd.substring(5, 7) + '/' + hsd.substring(0, 4);
                }

                // Highlight nếu sắp hết hoặc hết hàng
                const qtyColor = m.quantity === 0 ? 'color:var(--danger-red);font-weight:700;'
                               : m.quantity <= 100 ? 'color:var(--warning-orange);font-weight:700;' : '';

                return '<tr>'
                    + '<td><b>' + m.medicineId + '</b></td>'
                    + '<td>' + m.name + '</td>'
                    + '<td><span class="badge ' + badgeCls + '">' + m.category + '</span></td>'
                    + '<td style="' + qtyColor + '">' + m.quantity.toLocaleString() + '</td>'
                    + '<td>' + unit + '</td>'
                    + '<td>' + Number(m.price).toLocaleString('vi-VN') + 'đ</td>'
                    + '<td>' + hsd + '</td>'
                    + '</tr>';
            }).join('');
        }

        // ── Vẽ thanh phân trang ──
        function renderPagination() {
            const totalPages = Math.ceil(filtered.length / PAGE_SIZE);
            if (totalPages <= 1) { pagination.innerHTML = ''; return; }

            let html = '<span class="page-info">Trang ' + currentPage + '/' + totalPages + '</span>';

            // Nút Trước
            html += '<button class="page-btn" ' + (currentPage === 1 ? 'disabled' : '')
                  + ' onclick="goPage(' + (currentPage - 1) + ')">‹</button>';

            // Nút số trang (hiển thị tối đa 7 nút)
            const range = buildPageRange(currentPage, totalPages);
            range.forEach(p => {
                if (p === '...') {
                    html += '<span style="padding:0 4px;color:var(--text-muted);">…</span>';
                } else {
                    html += '<button class="page-btn ' + (p === currentPage ? 'active' : '') + '" onclick="goPage(' + p + ')">' + p + '</button>';
                }
            });

            // Nút Sau
            html += '<button class="page-btn" ' + (currentPage === totalPages ? 'disabled' : '')
                  + ' onclick="goPage(' + (currentPage + 1) + ')">›</button>';

            pagination.innerHTML = html;
        }

        function buildPageRange(cur, total) {
            if (total <= 7) return Array.from({length: total}, (_, i) => i + 1);
            const pages = [];
            if (cur <= 4) {
                for (let i = 1; i <= 5; i++) pages.push(i);
                pages.push('...'); pages.push(total);
            } else if (cur >= total - 3) {
                pages.push(1); pages.push('...');
                for (let i = total - 4; i <= total; i++) pages.push(i);
            } else {
                pages.push(1); pages.push('...');
                for (let i = cur - 1; i <= cur + 1; i++) pages.push(i);
                pages.push('...'); pages.push(total);
            }
            return pages;
        }

        function goPage(page) {
            currentPage = page;
            renderTable();
            renderPagination();
            window.scrollTo(0, 0);
        }

        // ── Gắn sự kiện ──
        searchInput.addEventListener('input', applyFilter);

        document.querySelectorAll('.btn-filter').forEach(btn => {
            btn.addEventListener('click', function () {
                document.querySelectorAll('.btn-filter').forEach(f => f.classList.remove('active'));
                this.classList.add('active');
                currentCategory = this.dataset.cat;
                applyFilter();
            });
        });

        // Khởi động
        fetchAll();
    </script>
</body>
</html>
