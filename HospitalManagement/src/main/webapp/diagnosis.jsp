<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chuẩn Đoán & Kê Đơn - Quản lý bệnh viện</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        .diagnosis-card { background: white; border-radius: 20px; padding: 32px; box-shadow: 0 4px 15px rgba(0,0,0,0.02); margin-bottom: 24px; position:relative;}
        .diagnosis-card h3 { font-size: 18px; margin-bottom: 20px; }
        .input-group { display: flex; gap: 24px; margin-bottom: 20px; }
        .input-box { flex: 1; position: relative;}
        .input-box label { display: block; font-size: 14px; margin-bottom: 8px; color: var(--text-main); font-weight: 500; }
        .input-box input { width: 100%; padding: 12px 16px; border: 1px solid var(--border-color); border-radius: 12px; font-size: 14px; outline: none; }
        .search-row { display: flex; gap: 16px; align-items: flex-end; }
        .tags { display: flex; gap: 10px; margin-top: 16px; }
        .tag { padding: 8px 16px; background: #EEF2FF; color: var(--primary-blue); border-radius: 20px; font-size: 14px; cursor: pointer; }
        .empty-state { text-align: center; padding: 60px 20px; color: var(--text-muted); }
        .empty-state .icon { font-size: 48px; margin-bottom: 16px; color: #CBD5E1; }
        .empty-state h2 { font-size: 20px; color: var(--text-main); margin-bottom: 8px; }
        
        .dropdown { position: absolute; top: 100%; left: 0; right: 0; background: white; border: 1px solid var(--border-color); border-radius: 8px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); z-index: 10; display: none; max-height: 200px; overflow-y: auto;}
        .dropdown-item { padding: 12px 16px; cursor: pointer; font-size: 14px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between;}
        .dropdown-item:hover { background-color: var(--background-gray); color: var(--primary-blue);}
    </style>
</head>
<body>

    <jsp:include page="includes/sidebar.jsp" />

    <div class="main-content">
        <div class="page-header" style="justify-content: flex-start; gap: 20px;">
            <div>
                <h1>Chuẩn Đoán & Kê Đơn</h1>
                <p>Nhập thông tin bệnh nhân để tiến hành khám</p>
            </div>
            <div style="margin-left: auto; font-size: 32px; color: var(--primary-blue);">🩺</div>
        </div>

        <div class="diagnosis-card">
            <h3>Tìm Kiếm Bệnh Nhân</h3>
            <div class="input-box">
                <input type="text" id="patientSearch" placeholder="🔍 Gõ tên hoặc mã bệnh nhân để tìm kiếm tự động...">
                <div id="patientDropdown" class="dropdown"></div>
            </div>
            
            <div id="patientDetails" style="display:none; margin-top:20px; padding: 16px; background: var(--background-gray); border-radius: 12px;">
                <h4 style="margin-bottom: 10px; color: var(--primary-blue);">Thông tin chi tiết:</h4>
                <p><b>Mã BN:</b> <span id="lblId"></span></p>
                <p><b>Họ & Tên:</b> <span id="lblName"></span></p>
                <p><b>Lịch sử chẩn đoán:</b> <span id="lblDiag"></span></p>
            </div>
        </div>

        <div class="diagnosis-card">
            <h3>Chuẩn Đoán Bệnh Mới</h3>
            <div class="search-row">
                <div class="input-box" style="margin-bottom: 0;">
                    <input type="text" id="diagInput" placeholder="🔍 Nhập chuẩn đoán: cảm cúm, đau dạ dày, cao huyết áp...">
                </div>
                <button class="btn-primary" style="padding: 12px 32px; border-radius: 12px;" onclick="startDiag()">Kê Đơn Thuốc</button>
            </div>
            <p style="margin-top: 20px; font-size: 14px; color: var(--text-muted);">Gợi ý chuẩn đoán phổ biến:</p>
            <div class="tags">
                <span class="tag" onclick="setDiag(this)">Cảm cúm</span>
                <span class="tag" onclick="setDiag(this)">Đau dạ dày</span>
                <span class="tag" onclick="setDiag(this)">Cao huyết áp</span>
                <span class="tag" onclick="setDiag(this)">Đái tháo đường</span>
                <span class="tag" onclick="setDiag(this)">Viêm họng</span>
            </div>
        </div>

        <div class="diagnosis-card empty-state" id="resultCard">
            <div class="icon">🩺</div>
            <h2>Bắt đầu chuẩn đoán</h2>
            <p>Nhập chuẩn đoán bệnh ở trên để xem phác đồ điều trị và danh sách thuốc phù hợp</p>
        </div>
    </div>

    <script>
        const CTX = '<%= request.getContextPath() %>';
        const patientSearch = document.getElementById('patientSearch');
        const patientDropdown = document.getElementById('patientDropdown');
        const patientDetails = document.getElementById('patientDetails');

        // Bắt sự kiện gõ phím -> gọi AJAX
        patientSearch.addEventListener('input', function() {
            const query = this.value;
            if(query.length < 1) {
                patientDropdown.style.display = 'none';
                return;
            }

            fetch(CTX + '/api/diagnosis/search?q=' + encodeURIComponent(query))
                .then(res => res.json())
                .then(data => {
                    patientDropdown.innerHTML = '';
                    if(data.length === 0) {
                        patientDropdown.innerHTML = '<div class="dropdown-item">Không tìm thấy bệnh nhân nào...</div>';
                    } else {
                        data.forEach(p => {
                            const div = document.createElement('div');
                            div.className = 'dropdown-item';
                            div.innerHTML = '<span>' + p.fullName + '</span> <span style="color:#888;">' + p.patientId + '</span>';
                            div.onclick = function() {
                                patientSearch.value = p.fullName;
                                patientDropdown.style.display = 'none';
                                document.getElementById('lblId').innerText = p.patientId;
                                document.getElementById('lblName').innerText = p.fullName;
                                document.getElementById('lblDiag').innerText = p.diagnosis || 'Chưa rõ';
                                patientDetails.style.display = 'block';
                            };
                            patientDropdown.appendChild(div);
                        });
                    }
                    patientDropdown.style.display = 'block';
                }).catch(err => console.error(err));
        });

        // Hide dropdown when clicking outside
        document.addEventListener('click', function(e) {
            if(e.target !== patientSearch) patientDropdown.style.display = 'none';
        });

        // Chọn tag nhanh
        function setDiag(element) {
            document.getElementById('diagInput').value = element.innerText;
        }

        // Hiện layout phác đồ mock
        function startDiag() {
            const val = document.getElementById('diagInput').value;
            if(!val) return alert("Vui lòng nhập chuẩn đoán!");
            const resultCard = document.getElementById('resultCard');
            resultCard.classList.remove('empty-state');
            resultCard.style.textAlign = 'left';
            resultCard.innerHTML = `
                <h3 style="color: var(--success-green);">Phác đồ được đề xuất cho: ` + val + `</h3>
                <div style="background: var(--background-gray); padding: 20px; border-radius: 12px; margin-top:20px;">
                    <p style="margin-bottom: 10px;"><b>Đơn thuốc tự động:</b></p>
                    <ul style="margin-left: 20px; line-height:1.8;">
                        <li>Paracetamol 500mg - 2 viên/ngày (Sáng, Tối)</li>
                        <li>Vitamin C 1000mg - 1 viên/ngày (Trưa)</li>
                    </ul>
                    <p style="margin-top: 20px; color: var(--text-muted);">* Lưu ý: Bác sĩ có thể chỉnh sửa lại đơn thuốc trước khi in.</p>
                </div>
                <button class="btn-primary" style="margin-top:20px; width: 100%;">Lưu đơn thuốc & In</button>
            `;
        }
    </script>
</body>
</html>
