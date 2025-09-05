<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Management Application</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-size: 0.9rem;
            background-image: url("https://images.unsplash.com/photo-1503676260728-1c00da094a0b"); /* link ảnh */
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }
        /* lớp phủ mờ */
        .overlay {
            background-color: rgba(255, 255, 255, 0.7); /* chỉnh opacity để ảnh hiện rõ hơn */
            min-height: 100vh;
            padding: 20px;
        }
        table td, table th { white-space: nowrap; }
        table th {
            font-size: 0.5rem;   /* làm nhỏ chữ th */
            font-weight: 600;
        }
        table td {
            font-size: 0.5rem;  /* ô dữ liệu cũng gọn lại một chút */
        }
        .sticky-col {
            position: sticky;
            right: 0;
            background: #fff;
            z-index: 2;
        }
    </style>

</head>
<body>
<div class="overlay">
    <div class="container mt-5">

        <div class="text-center mb-4">
            <h2 class="fw-bold text-primary">Quản lí sinh viên</h2>
            <c:if test="${sessionScope.role eq 'ADMIN'}">
                <a href="${pageContext.request.contextPath}/students?action=create"
                   class="btn btn-success btn-sm mt-2">➕ Thêm mới sinh viên</a>
            </c:if>
        </div>

        <!-- Thông báo -->
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success alert-dismissible fade show small" role="alert">
                    ${sessionScope.message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="message" scope="session"/>
        </c:if>

        <!-- Danh sách sinh viên -->
        <div class="card shadow">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0" style="text-align: center">Danh sách sinh viên</h5>
            </div>
            <div class="card-body p-2">
                <div class="table-responsive">
                    <table class="table table-sm table-striped table-bordered table-hover align-middle text-center">
                        <thead class="table-dark small">
                        <tr>
                            <th>ID</th>
                            <th>Họ Tên</th>
                            <th>Ngày sinh</th>
                            <th>Địa chỉ</th>
                            <th>Email</th>
                            <th>Số điện thoại</th>
                            <th>Điểm trung bình</th>
                            <th>Tên lớp</th>
                            <c:if test="${sessionScope.role eq 'ADMIN'}">
                                <th class="sticky-col">Thao tác</th>
                            </c:if>
                        </tr>
                        </thead>
                        <tbody class="small">
                        <c:forEach var="student" items="${studentList}">
                            <tr>
                                <td><c:out value="${student.id}"/></td>
                                <td><c:out value="${student.name}"/></td>
                                <td><c:out value="${student.birthday}"/></td>
                                <td><c:out value="${student.address}"/></td>
                                <td><c:out value="${student.email}"/></td>
                                <td><c:out value="${student.phone}"/></td>
                                <td><c:out value="${student.averageGrade}"/></td>
                                <td><c:out value="${student.className}"/></td>

                                <c:if test="${sessionScope.role eq 'ADMIN'}">
                                    <td class="sticky-col">
                                        <a href="${pageContext.request.contextPath}/students?action=edit&id=${student.id}"
                                           class="btn btn-warning btn-sm me-1" title="Sửa">✏️</a>
                                        <a href="${pageContext.request.contextPath}/students?action=delete&id=${student.id}"
                                           class="btn btn-danger btn-sm" title="Xoá"
                                           onclick="return confirm('Bạn có chắc muốn xoá sinh viên này?');">🗑️</a>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Logout -->
        <div class="text-center mt-3">
            <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-secondary btn-sm">🚪 Logout</a>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
