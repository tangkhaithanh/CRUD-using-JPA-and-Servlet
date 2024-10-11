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
    
    <!-- Form tìm kiếm -->
    <form action="<c:url value='/admin/video/search'></c:url>" method="get" style="text-align: center; margin-bottom: 20px;">
        <input type="hidden" name="page" value="${currentPage}" /> <!-- Thêm tham số trang hiện tại -->
        <input type="hidden" name="pageSize" value="${pageSize}" /> <!-- Thêm tham số kích thước trang -->
        <input type="text" name="keyword" placeholder="Tìm kiếm theo tiêu đề..." required />
        <button type="submit">Tìm kiếm</button>
    </form>
    
    
    
    <table>
        <tr>
            <th>STT</th>
            <th>Hình đại diện</th>
            <th>Tiêu đề</th>
            <th>Mô tả</th>
            <th>Thể loại</th>
            <th>Lượt xem</th>
            <th>Trạng thái</th>
            <th>Thao tác</th>
        </tr>
        <c:forEach items="${listVideos}" var="video" varStatus="status">
            <tr>
                <td>${(currentPage * pageSize) + status.index + 1}</td> <!-- Tính số thứ tự video -->
                <td><img src="<c:url value='/images/${video.poster}'/>" alt="${video.title}"/></td>
                <td>${video.title}</td>
                <td>${video.description}</td>
                <td>${video.categoryName}</td>
                <td>${video.views}</td>
                <td>${video.active == 1 ? 'Kích hoạt' : 'Khóa'}</td>
                <td class="action-links">
                    <a href="<c:url value='/admin/video/edit?id=${video.videoId}'/>">Sửa</a> |
                    <a href="<c:url value='/admin/video/delete?id=${video.videoId}'/>">Xóa</a>
                </td>
            </tr>
        </c:forEach>
    </table>
<!-- kiểm tra: -->
		
		<c:if test="${empty listVideos}">
		    <p>Không có video nào phù hợp với tìm kiếm của bạn.</p>
		</c:if>

<!-- Phân trang -->
	<c:if test="${totalPages > 1}">
        <div style="text-align: center; margin-top: 20px;">
            <!-- Nút "Trước" -->
            <c:if test="${currentPage > 0}">
                <a href="<c:url value='?page=${currentPage - 1}&keyword=${param.keyword}&pageSize=${pageSize}'/>" style="margin: 0 5px; padding: 5px 10px; text-decoration: none; color: #333; background-color: #f0f0f0; border-radius: 5px;">Trước</a>
            </c:if>

            <!-- Hiển thị các số trang -->
            <c:forEach begin="0" end="${totalPages - 1}" var="pageNum">
                <c:choose>
                    <c:when test="${pageNum == currentPage}">
                        <span style="display: inline-block; margin: 0 5px; padding: 5px 10px; background-color: #007BFF; color: white; border-radius: 5px;">${pageNum + 1}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='?page=${pageNum}&keyword=${param.keyword}&pageSize=${pageSize}'/>" style="display: inline-block; margin: 0 5px; padding: 5px 10px; text-decoration: none; color: #333; background-color: #f0f0f0; border-radius: 5px;">${pageNum + 1}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <!-- Nút "Tiếp" -->
            <c:if test="${currentPage < totalPages - 1}">
                <a href="<c:url value='?page=${currentPage + 1}&keyword=${param.keyword}&pageSize=${pageSize}'/>" style="margin: 0 5px; padding: 5px 10px; text-decoration: none; color: #333; background-color: #f0f0f0; border-radius: 5px;">Tiếp</a>
            </c:if>
        </div>
    </c:if>
    	
</body>
</html>
