<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập nhật Thể loại</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .form-container {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
            color: #333;
        }
        label {
            font-weight: bold;
            margin-top: 10px;
            display: block;
        }
        input[type="text"],
        input[type="file"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="radio"] {
            margin-right: 5px;
        }
        input[type="submit"] {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 4px;
            cursor: pointer;
            width: 100%;
            margin-top: 20px;
        }
        input[type="submit"]:hover {
            background-color: #218838;
        }
        img {
            margin-top: 10px;
            border-radius: 4px;
        }
        .status-label {
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>Cập nhật Thể loại</h2>
    <form action="<c:url value='/admin/category/update'></c:url>" method="post" enctype="multipart/form-data">
        <input type="hidden" id="categoryid" name="categoryid" value="${cate.categoryId}">

        <label for="categoryname">Tên thể loại:</label>
        <input type="text" id="categoryname" name="categoryname" value="${cate.categoryname}" required>

        <label class="status-label">Trạng thái:</label>
        <input type="radio" id="active" name="status" value="1" <c:if test="${cate.status == 1}">checked</c:if>>
        <label for="active">Kích hoạt</label>
        <input type="radio" id="inactive" name="status" value="0" <c:if test="${cate.status == 0}">checked</c:if>>
        <label for="inactive">Khóa</label>

        <label for="images">Hình đại diện hiện tại:</label>
        <c:if test="${not empty cate.images}">
            <img id="currentImage" src="<c:url value='/images/${cate.images}'/>" height="150" width="200" alt="Current Image">
        </c:if>
        <c:if test="${empty cate.images}">
            <p class="text-red-500">Không có hình ảnh hiện tại</p>
        </c:if>

        <label for="images">Thay đổi hình đại diện:</label>
        <input type="file" id="images" name="images">

        <input type="submit" value="Cập nhật Thể loại">
    </form>
</div>

<!-- JavaScript để xử lý việc chọn tệp và hiển thị ảnh mới -->
<script>
    document.getElementById('images').addEventListener('change', function(event) {
        var reader = new FileReader();
        reader.onload = function(e) {
            var image = document.getElementById('currentImage');
            image.src = e.target.result; // Cập nhật ảnh mới
        };
        reader.readAsDataURL(event.target.files[0]);
    });
</script>

</body>
</html>
