<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách Video</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .table-responsive {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .table {
            margin-bottom: 0;
        }
        .table th {
            background-color: #007bff;
            color: white;
            border: none;
        }
        .table td {
            vertical-align: middle;
        }
        .table-hover tbody tr:hover {
            background-color: #f1f8ff;
        }
        .poster-img {
            width: 100px;
            height: 75px;
            object-fit: cover;
            border-radius: 4px;
        }
        .pagination {
            justify-content: center;
        }
        .logout-button {
            position: absolute;
            top: 20px;
            right: 20px;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <a href="<c:url value='/user/logout'></c:url>" class="btn btn-danger logout-button">
            <i class="fas fa-sign-out-alt"></i> Đăng xuất
        </a>
        <h2 class="text-center mb-4">Danh sách Video</h2>
        
        <!-- Form tìm kiếm -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <form action="<c:url value='/home/search'></c:url>" method="get" class="d-flex">
                <input type="hidden" name="page" value="${currentPage}" />
                <input type="hidden" name="pageSize" value="${pageSize}" />
                <input type="text" name="keyword" class="form-control me-2" placeholder="Tìm kiếm theo tiêu đề..." required />
                <button type="submit" class="btn btn-outline-primary">
                    <i class="fas fa-search"></i>
                </button>
            </form>
        </div>
        
        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Hình đại diện</th>
                        <th>Tiêu đề</th>
                        <th>Mô tả</th>
                        <th>Thể loại</th>
                        <th>Lượt xem</th>
                        <th>Trạng thái</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listVideos}" var="video" varStatus="status">
                        <tr>
                            <td>${(currentPage * pageSize) + status.index + 1}</td>
                            <td><img src="<c:url value='/images/${video.poster}'/>" alt="${video.title}" class="poster-img"/></td>
                            <td>${video.title}</td>
                            <td>${video.description}</td>
                            <td>${video.categoryName}</td>
                            <td>${video.views}</td>
                            <td>
                                <span class="badge ${video.active == 1 ? 'bg-success' : 'bg-danger'}">
                                    ${video.active == 1 ? 'Kích hoạt' : 'Khóa'}
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <c:if test="${empty listVideos}">
            <div class="alert alert-info mt-3" role="alert">
                Không có video nào phù hợp với tìm kiếm của bạn.
            </div>
        </c:if>

        <c:if test="${totalPages > 1}">
            <nav aria-label="Page navigation" class="mt-4">
                <ul class="pagination">
                    <c:if test="${currentPage > 0}">
                        <li class="page-item">
                            <a class="page-link" href="<c:url value='?page=${currentPage - 1}&keyword=${param.keyword}&pageSize=${pageSize}'/>" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    
                    <c:forEach begin="0" end="${totalPages - 1}" var="pageNum">
                        <li class="page-item ${pageNum == currentPage ? 'active' : ''}">
                            <a class="page-link" href="<c:url value='?page=${pageNum}&keyword=${param.keyword}&pageSize=${pageSize}'/>">${pageNum + 1}</a>
                        </li>
                    </c:forEach>
                    
                    <c:if test="${currentPage < totalPages - 1}">
                        <li class="page-item">
                            <a class="page-link" href="<c:url value='?page=${currentPage + 1}&keyword=${param.keyword}&pageSize=${pageSize}'/>" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </c:if>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>