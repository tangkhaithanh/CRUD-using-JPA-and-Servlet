<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh sửa Video</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
        }

        label {
            font-weight: bold;
            margin-bottom: 5px;
        }

        input[type="text"], input[type="number"], textarea, select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ddd;
            box-sizing: border-box; /* Đảm bảo padding không làm tăng chiều rộng */
        }

        .status-container {
            display: flex;
            align-items: center; /* Căn giữa theo chiều dọc */
            margin-bottom: 15px;
        }

        .status-container input[type="radio"] {
            margin-right: 5px; /* Khoảng cách giữa nút radio và label */
        }

        .status-container label {
            margin-right: 20px; /* Khoảng cách giữa các label */
        }

        .image-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 15px;
        }

        img {
            max-height: 150px; /* Điều chỉnh chiều cao tối đa */
            max-width: 100%;   /* Đảm bảo không vượt quá chiều rộng khung */
            object-fit: cover;  /* Đảm bảo hình ảnh không bị méo */
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-bottom: 10px;
        }

        input[type="file"] {
            display: none; /* Ẩn nút nhập tệp */
        }

        .custom-file-upload {
            background-color: #007BFF;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            text-align: center; /* Căn giữa văn bản */
            margin-bottom: 15px;
        }

        .custom-file-upload:hover {
            background-color: #0056b3;
        }

        input[type="submit"] {
            background-color: #007BFF;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .message {
            color: #ff0000;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<form action="<c:url value='/admin/video/update'></c:url>" method="post" enctype="multipart/form-data">
    <input type="hidden" id="videoId" name="videoId" value="${video.videoId}">

    <label for="title">Tiêu đề:</label>
    <input type="text" id="title" name="title" value="${video.title}" required>

    <label for="description">Mô tả:</label>
    <textarea id="description" name="description" required>${video.description}</textarea>

    <label for="views">Lượt xem:</label>
    <input type="number" id="views" name="views" value="${video.views}" min="0" required>

    <label for="active">Trạng thái:</label>
    <div class="status-container">
        <input type="radio" id="active" name="active" value="1" <c:if test="${video.active == 1}">checked</c:if>>
        <label for="active">Kích hoạt</label>
        <input type="radio" id="inactive" name="active" value="0" <c:if test="${video.active == 0}">checked</c:if>>
        <label for="inactive">Khóa</label>
    </div>

    <label for="categoryId">Chọn thể loại:</label>
    <select id="categoryId" name="categoryId" required>
        <c:forEach items="${categories}" var="category">
            <option value="${category.categoryId}" <c:if test="${category.categoryId == video.category.categoryId}">selected</c:if>>${category.categoryname}</option>
        </c:forEach>
    </select>

    <label for="poster">Hình đại diện hiện tại:</label>
    <div class="image-container">
    <img id="currentPoster" src="<c:url value='/images/${video.poster}'/>" alt="Hình đại diện hiện tại" style="display: ${empty video.poster ? 'none' : 'block'};">
    <p id="noPosterMessage" class="message" style="display: ${empty video.poster ? 'block' : 'none'};">Chưa có hình đại diện.</p>
</div>

<label for="poster">Thay đổi hình đại diện:</label>
<label class="custom-file-upload" for="poster">
    Chọn tệp
</label>
<input type="file" id="poster" name="poster" onchange="updateImagePreview(this)">

<input type="submit" value="Cập nhật Video">
</form>

<script>
    const currentPosterSrc = '<c:url value="/images/${video.poster}"/>';

    function updateImagePreview(input) {
        const file = input.files[0];
        const imgElement = document.getElementById('currentPoster');
        const noImageMessage = document.getElementById('noPosterMessage');

        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                imgElement.src = e.target.result;
                imgElement.alt = file.name;
                imgElement.style.display = 'block';
                noImageMessage.style.display = 'none';
            }
            reader.readAsDataURL(file);
        } else {
            imgElement.src = currentPosterSrc;
            if (currentPosterSrc.endsWith('/images/')) {
                imgElement.style.display = 'none';
                noImageMessage.style.display = 'block';
            } else {
                imgElement.style.display = 'block';
                noImageMessage.style.display = 'none';
            }
        }
    }

    // Thêm đoạn code này để kiểm tra hình ảnh khi trang load
    window.onload = function() {
        const imgElement = document.getElementById('currentPoster');
        const noImageMessage = document.getElementById('noPosterMessage');
        
        if (currentPosterSrc.endsWith('/images/')) {
            imgElement.style.display = 'none';
            noImageMessage.style.display = 'block';
        } else {
            imgElement.style.display = 'block';
            noImageMessage.style.display = 'none';
        }
    }
</script>