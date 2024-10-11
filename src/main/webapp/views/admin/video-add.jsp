<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Video</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        h1 {
            color: #333;
            text-align: center;
        }

        form {
            max-width: 500px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin: 10px 0 5px;
        }

        input[type="text"], 
        input[type="number"], 
        select, 
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        input[type="file"] {
            margin-bottom: 15px;
            width: 100%;
        }

        .poster-preview {
            width: 100%;
            height: 300px;
            margin: 10px 0;
            border: 1px dashed #ccc;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
            background-color: #f9f9f9;
        }

        .poster-preview img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        input[type="submit"] {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
            width: 100%;
        }

        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
    <script>
        function previewImage(event) {
            const reader = new FileReader();
            const preview = document.getElementById('poster-preview');

            reader.onload = function() {
                const img = document.createElement('img');
                img.src = reader.result;
                preview.innerHTML = ''; // Xóa ảnh cũ
                preview.appendChild(img);
            }

            reader.readAsDataURL(event.target.files[0]);
        }
    </script>
</head>
<body>
<h1>Add New Video</h1>
<form action="${pageContext.request.contextPath}/admin/video/insert" method="post" enctype="multipart/form-data">
    <label for="title">Title:</label>
    <input type="text" id="title" name="title" required>

    <label for="description">Description:</label>
    <textarea id="description" name="description" required></textarea>

    <label for="poster">Poster:</label>
    <input type="file" id="poster" name="poster" accept="image/*" required onchange="previewImage(event)">

    <div class="poster-preview" id="poster-preview">
        <p>No image selected</p>
    </div>

    <label for="views">Views:</label>
    <input type="number" id="views" name="views" required>
	<!-- tạo dropdown list như combo box trong C# -->
    <label for="categoryId">Category:</label>
    <select id="categoryId" name="categoryId" required>
        <c:forEach var="category" items="${categories}">
            <option value="${category.categoryId}">${category.categoryname}</option>
        </c:forEach>
    </select>

    <!-- Thêm trường Active -->
    <label for="active">Active:</label>
    <select id="active" name="active" required>
        <option value="1">Active</option>
        <option value="0">Inactive</option>
    </select>

    <input type="submit" value="Add Video">
</form>
</body>
</html>