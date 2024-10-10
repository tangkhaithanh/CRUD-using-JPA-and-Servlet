<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách Thể loại</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.2.19/tailwind.min.css" rel="stylesheet">
    <style>
        .table-container {
            overflow-x: auto;
        }

        th {
            background-color: #3b82f6; /* Màu xanh */
            color: white; /* Màu chữ trắng */
        }
    </style>
</head>

<body class="bg-gray-100 p-6">
    <div class="container mx-auto bg-white p-6 rounded-lg shadow-lg">
        <h2 class="text-3xl font-bold mb-4 text-gray-800 text-center">Danh sách Thể loại</h2>
        
        <div class="text-center mb-4">
            <a href="<c:url value='/admin/category/add'></c:url>" class="bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded transition duration-300">
                Thêm Thể loại
            </a>
        </div>

        <div class="table-container">
            <table class="min-w-full border border-gray-300">
                <thead>
                    <tr>
                        <th class="px-4 py-2 border">STT</th>
                        <th class="px-4 py-2 border">Hình ảnh</th>
                        <th class="px-4 py-2 border">Tên Thể loại</th>
                        <th class="px-4 py-2 border">Trạng thái</th>
                        <th class="px-4 py-2 border">Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listcate}" var="cate" varStatus="status">
                        <tr class="hover:bg-gray-100 transition duration-300">
                            <td class="px-4 py-2 border">${status.index + 1}</td>

                            <td class="px-4 py-2 border">
                                <c:if test="${not empty cate.images}">
                                    <img src="<c:url value='/images/${cate.images}'/>" height="100" width="150" class="rounded"/>
                                </c:if>
                                <c:if test="${empty cate.images}">
                                    <p class="text-red-500">Không có hình ảnh</p>
                                </c:if>
                            </td>

                            <td class="px-4 py-2 border">${cate.categoryname}</td>
                            <td class="px-4 py-2 border">
                                <span class="${cate.status == 1 ? 'text-green-500' : 'text-red-500'}">
                                    ${cate.status == 1 ? 'Kích hoạt' : 'Khóa'}
                                </span>
                            </td>
                            <td class="px-4 py-2 border">
                                <a href="<c:url value='/admin/category/edit?id=${cate.categoryId }'/>" class="text-yellow-500 hover:underline">Sửa</a> |
                                <a href="<c:url value='/admin/category/delete?id=${cate.categoryId }'/>" class="text-red-500 hover:underline">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>

</html>
