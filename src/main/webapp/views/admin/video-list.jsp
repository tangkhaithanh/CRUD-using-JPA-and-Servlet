<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách Video</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        a {
            text-decoration: none;
            color: #fff;
            background-color: #007BFF;
            padding: 10px 15px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }

        a:hover {
            background-color: #0056b3;
        }

        table {
            width: 100%;
            border-collapse: collapse; /* Đảm bảo không có khoảng cách giữa các ô */
            margin-top: 20px;
            background-color: #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            overflow: hidden;
            border: 2px solid #007BFF; /* Thêm khung cho bảng */
        }

        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd; /* Đường viền dưới mỗi ô */
            border-right: 1px solid #ddd; /* Đường viền bên phải mỗi ô */
        }

        th {
            background-color: #007BFF;
            color: white;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        td img {
            border-radius: 5px;
            width: 100%;
            height: 150px;
            object-fit: cover;
            display: block;
        }

        .action-links a {
            margin-right: 10px;
        }

        table td:nth-child(2) {
            width: 200px;
        }

        /* Tùy chỉnh đường viền cho hàng cuối */
        table tr:last-child td {
            border-bottom: none; /* Không kẻ đường viền cho hàng cuối */
        }

        /* Đường viền cho ô đầu tiên của mỗi hàng */
        tr td:first-child {
            border-left: 2px solid #007BFF; /* Đường viền bên trái cho ô đầu tiên */
        }

        /* Đường viền cho các ô cuối cùng */
        tr td:last-child {
            border-right: none; /* Không kẻ đường viền bên phải cho ô cuối cùng */
        }
    </style>
</head>
<body>
    <h2>Danh sách Video</h2>
    <div style="text-align: center; margin-bottom: 20px;">
        <a href="<c:url value='/admin/video/add'></c:url>">Thêm Video</a>
    </div>
    <table>
        <tr>
            <th>STT</th>
            <th>Hình đại diện</th>
            <th>Tiêu đề</th>
            <th>Mô tả</th>
            <th>Lượt xem</th>
            <th>Trạng thái</th>
            <th>Thao tác</th>
        </tr>
        <c:forEach items="${listVideos}" var="video" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td><img src="<c:url value='/images/${video.poster}'/>" alt="${video.title}"/></td>
                <td>${video.title}</td>
                <td>${video.description}</td>
                <td>${video.views}</td>
                <td>${video.active == 1 ? 'Kích hoạt' : 'Khóa'}</td>
                <td class="action-links">
                    <a href="<c:url value='/admin/video/edit?id=${video.videoId}'/>">Sửa</a> |
                    <a href="<c:url value='/admin/video/delete?id=${video.videoId}'/>">Xóa</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
