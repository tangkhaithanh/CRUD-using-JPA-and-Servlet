<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký</title>
    <!-- Google Fonts: Roboto, hỗ trợ tiếng Việt -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            background-color: #f1f4f7;
            font-family: 'Roboto', sans-serif;
        }
        .register-container {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        .register-box {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            max-width: 500px;
            width: 100%;
        }
        .register-box h2 {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 20px;
            text-align: center;
        }
        .register-box .form-control {
            border-radius: 30px;
            padding: 10px 20px;
            margin-bottom: 20px;
        }
        .register-box .btn-primary {
            background-color: #52b69a;
            border-radius: 30px;
            padding: 10px;
            font-size: 16px;
            width: 100%;
        }
        .register-box .btn-primary:hover {
            background-color: #3a7ca5;
        }
        .register-box .text-center a {
            color: #007bff;
            text-decoration: none;
        }
        .register-box .text-center a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container register-container">
        <div class="register-box">
            <h2>Đăng ký tài khoản</h2>
            <form action="<c:url value='/user/register'></c:url>" method="post">
                <div class="mb-3">
                    <input type="text" class="form-control" id="username" name="username" placeholder="Tên người dùng" required>
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" id="password" name="password" placeholder="Mật khẩu" required>
                </div>
                <div class="mb-3">
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Xác nhận mật khẩu" required>
                </div>
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger">${errorMessage}</div>
                </c:if>
                <button type="submit" class="btn btn-primary">Đăng ký</button>
                <div class="mt-3 text-center">
                    <a href="<c:url value='/user/login'></c:url>">Đã có tài khoản? Đăng nhập ngay</a>
                </div>
            </form>
        </div>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
