<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập</title>
    <!-- Google Fonts: Roboto, hỗ trợ tiếng Việt -->
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            background-color: #f1f4f7;
            font-family: 'Roboto', sans-serif;
        }
        .login-container {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        .login-box {
            display: flex;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            max-width: 900px;
            width: 100%;
        }
        .login-left {
            padding: 40px;
            width: 50%;
        }
        .login-right {
            background: linear-gradient(135deg, #52b69a, #3a7ca5);
            padding: 40px;
            width: 50%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            color: white;
            text-align: center;
        }
        .login-left h2 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 20px;
        }
        .login-left .social-login {
            display: flex;
            justify-content: space-around;
            margin-bottom: 20px;
        }
        .login-left .social-login a {
            width: 45px;
            height: 45px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            font-size: 20px;
            color: white;
        }
        .login-left .social-login a.facebook {
            background-color: #3b5998;
        }
        .login-left .social-login a.google {
            background-color: #dd4b39;
        }
        .login-left .social-login a.linkedin {
            background-color: #0077b5;
        }
        .login-left form {
            margin-top: 20px;
        }
        .login-left .form-control {
            border-radius: 30px;
            padding: 10px 20px;
            margin-bottom: 20px;
        }
        .login-left .btn-primary {
            background-color: #52b69a;
            border-radius: 30px;
            padding: 10px;
            font-size: 16px;
        }
        .login-right h3 {
            font-size: 28px;
            font-weight: bold;
        }
        .login-right p {
            margin: 20px 0;
        }
        .login-right .btn {
            background-color: white;
            color: #52b69a;
            border-radius: 30px;
            padding: 10px 20px;
        }
    </style>
</head>
<body>
    <div class="container login-container">
        <div class="login-box">
            <!-- Left Section (Login) -->
            <div class="login-left">
                <h2>Login to Your Account</h2>
                <p class="text-center">Login using social networks</p>
                <div class="social-login">
                    <a href="#" class="facebook"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="google"><i class="fab fa-google"></i></a>
                    <a href="#" class="linkedin"><i class="fab fa-linkedin-in"></i></a>
                </div>
                <form action="<c:url value='/user/login'></c:url>" method="post">
                    <div class="mb-3">
                        <input type="text" class="form-control" id="username" name="username" placeholder="Email" required>
                    </div>
                    <div class="mb-3">
                        <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                    </div>
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger">${errorMessage}</div>
                    </c:if>
                    <button type="submit" class="btn btn-primary w-100">Sign In</button>
                </form>
            </div>
            <!-- Right Section (Signup Prompt) -->
            <div class="login-right">
                <h3>New Here?</h3>
                <p>Sign up and discover a great amount of new opportunities!</p>
                <a href="<c:url value='/user/register'></c:url>" class="btn">Sign Up</a>
            </div>
        </div>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>
