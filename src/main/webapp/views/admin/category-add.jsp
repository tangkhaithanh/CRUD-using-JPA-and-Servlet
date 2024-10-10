<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Thể loại</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e9ecef; /* Màu nền sáng hơn */
            margin: 0;
            padding: 20px;
        }
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            background: #ffffff; /* Màu nền trắng cho khung */
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2); /* Đổ bóng mượt mà hơn */
            transition: transform 0.2s; /* Hiệu ứng khi di chuột */
        }
        .form-container:hover {
            transform: scale(1.02); /* Tăng kích thước một chút khi hover */
        }
        h2 {
            text-align: center;
            color: #007bff; /* Màu xanh dương cho tiêu đề */
        }
        label {
            font-weight: bold;
            margin-top: 10px;
            display: block;
            color: #495057; /* Màu chữ tối hơn */
        }
        input[type="text"],
        input[type="file"],
        input[type="radio"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 2px solid #007bff; /* Đường viền màu xanh dương */
            border-radius: 4px;
            transition: border-color 0.3s; /* Hiệu ứng khi thay đổi màu viền */
        }
        input[type="text"]:focus,
        input[type="file"]:focus {
            border-color: #0056b3; /* Màu viền khi input được chọn */
            outline: none; /* Xóa viền mặc định của trình duyệt */
        }
        .radio-group {
            display: flex; /* Hiển thị nút radio trên cùng một hàng */
            align-items: center; /* Căn giữa các nút radio */
            gap: 15px; /* Khoảng cách giữa các nút radio */
        }
        .status-label {
            display: flex;
            align-items: center; /* Căn giữa chữ và nút radio */
        }
        input[type="submit"] {
            background-color: #28a745; /* Màu xanh lá cho nút submit */
            color: white;
            border: none;
            padding: 10px;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            margin-top: 20px;
            transition: background-color 0.3s; /* Hiệu ứng khi di chuột */
        }
        input[type="submit"]:hover {
            background-color: #218838; /* Màu xanh lá đậm khi hover */
        }
        img {
            margin-top: 10px;
            border-radius: 4px;
            display: none; /* Ảnh không hiển thị trước khi chọn */
            max-width: 100%; /* Đảm bảo ảnh không quá rộng */
            height: auto; /* Giữ tỉ lệ khung hình */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Đổ bóng cho ảnh */
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Thêm Thể loại</h2>
    <form action="<c:url value='/admin/category/insert'></c:url>" method="post" enctype="multipart/form-data">
        <label for="categoryname">Tên Thể loại:</label>
        <input type="text" id="categoryname" name="categoryname" required>

        <label for="images">Hình ảnh:</label>
        <input type="file" id="images" name="images" accept="image/*" onchange="chooseFile(this)" required><br>

        <!-- Khung hiển thị ảnh -->
        <img id="imagePreview" src="" alt="Preview Image">

        <label>Trạng thái:</label>
        <div class="radio-group">
            <div class="status-label">
                <input type="radio" id="active" name="status" value="1" checked>
                <label for="active">Đang hoạt động</label>
            </div>
            <div class="status-label">
                <input type="radio" id="inactive" name="status" value="0">
                <label for="inactive">Khóa</label>
            </div>
        </div>

        <input type="submit" value="Thêm Thể loại">
    </form>
</div>

<script>
    function chooseFile(fileInput) {
        var reader = new FileReader();
        reader.onload = function(e) {
            // Lấy thẻ img và gán giá trị src bằng dữ liệu ảnh
            var image = document.getElementById('imagePreview');
            image.src = e.target.result;
            image.style.display = 'block'; // Hiển thị ảnh sau khi chọn file
        };
        // Đọc file ảnh từ input
        reader.readAsDataURL(fileInput.files[0]);
    }
</script>

</body>
</html>
