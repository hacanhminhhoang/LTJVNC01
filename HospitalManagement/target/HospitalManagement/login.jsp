<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng Nhập - Quản Lý Bệnh Viện</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { justify-content: center; align-items: center; background-color: var(--background-gray); }
        .login-container { background: white; padding: 40px; border-radius: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); width: 100%; max-width: 400px; text-align: center; }
        .login-logo { width: 64px; height: 64px; background-color: var(--primary-blue); border-radius: 16px; display: inline-flex; align-items: center; justify-content: center; color: white; font-size: 32px; margin-bottom: 24px; }
        .login-container h2 { margin-bottom: 8px; color: var(--text-main); }
        .login-container p { color: var(--text-muted); margin-bottom: 32px; font-size: 14px; }
        .form-group { text-align: left; margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-size: 14px; font-weight: 500; color: var(--text-main); }
        .form-group input { width: 100%; padding: 14px 16px; border: 1px solid var(--border-color); border-radius: 12px; font-size: 14px; outline: none; transition: 0.3s; }
        .form-group input:focus { border-color: var(--primary-blue); }
        .btn-block { width: 100%; margin-top: 10px; }
        .error-msg { color: var(--danger-red); font-size: 13px; margin-bottom: 16px; display: block; font-weight: 500; }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-logo">🏥</div>
        <h2>Hệ Thống Y Tế</h2>
        <p>Đăng nhập để vào bảng điều khiển</p>
        
        <c:if test="${not empty error}">
            <span class="error-msg">${error}</span>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-group">
                <label>Tên đăng nhập</label>
                <input type="text" name="username" placeholder="Nhập tài khoản (VD: admin)" required>
            </div>
            <div class="form-group">
                <label>Mật khẩu</label>
                <input type="password" name="password" placeholder="Nhập mật khẩu (VD: 123456)" required>
            </div>
            <button type="submit" class="btn-primary btn-block">Đăng Nhập</button>
        </form>
    </div>
</body>
</html>
