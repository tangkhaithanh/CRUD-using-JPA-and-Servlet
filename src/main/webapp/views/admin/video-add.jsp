<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Video</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .form-container {
            max-width: 600px;
            margin: 30px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        .poster-preview {
            width: 100%;
            height: 300px;
            border: 2px dashed #ced4da;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            position: relative;
            background-color: #f8f9fa;
            margin-bottom: 1rem;
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
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h1 class="text-center mb-4">Add New Video</h1>
            <form action="${pageContext.request.contextPath}/admin/video/insert" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="title" class="form-label">Title:</label>
                    <input type="text" class="form-control" id="title" name="title" required>
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label">Description:</label>
                    <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                </div>

                <div class="mb-3">
                    <label for="poster" class="form-label">Poster:</label>
                    <input type="file" class="form-control" id="poster" name="poster" accept="image/*" required onchange="previewImage(event)">
                </div>

                <div class="poster-preview" id="poster-preview">
                    <p class="text-muted">No image selected</p>
                </div>

                <div class="mb-3">
                    <label for="views" class="form-label">Views:</label>
                    <input type="number" class="form-control" id="views" name="views" required>
                </div>

                <div class="mb-3">
                    <label for="categoryId" class="form-label">Category:</label>
                    <select class="form-select" id="categoryId" name="categoryId" required>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.categoryId}">${category.categoryname}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label for="active" class="form-label">Active:</label>
                    <select class="form-select" id="active" name="active" required>
                        <option value="1">Active</option>
                        <option value="0">Inactive</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-primary w-100">Add Video</button>
            </form>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        function previewImage(event) {
            const reader = new FileReader();
            const preview = document.getElementById('poster-preview');

            reader.onload = function() {
                const img = document.createElement('img');
                img.src = reader.result;
                preview.innerHTML = ''; // Xóa nội dung cũ
                preview.appendChild(img);
            }

            reader.readAsDataURL(event.target.files[0]);
        }
    </script>
</body>
</html>