<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Management Application</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            font-size: 0.9rem;
            background-image: url("https://images.unsplash.com/photo-1503676260728-1c00da094a0b");
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            margin-top: 56px; /* bù cho navbar cố định */
        }

        .overlay {
            background-color: rgba(255, 255, 255, 0.85);
            min-height: 100vh;
            padding: 20px;
        }

        table td, table th {
            white-space: nowrap;
        }

        table th {
            font-size: 0.75rem;
            font-weight: 600;
        }

        table td {
            font-size: 0.75rem;
        }

        .sticky-col {
            position: sticky;
            right: 0;
            background: #fff;
            z-index: 2;
        }

        .card {
            border-radius: 0.75rem;
        }

        .navbar-brand {
            font-weight: bold;
            color: #fff !important;
        }
    </style>
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top shadow">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Student Manager</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <c:if test="${sessionScope.role eq 'ADMIN'}">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/students?action=create">➕ Add
                            Student</a>
                    </li>
                </c:if>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/login">🚪 Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="overlay">
    <div class="container mt-4">
        <!-- Thông báo -->
        <c:if test="${not empty sessionScope.message}">
            <div class="alert alert-success alert-dismissible fade show small" role="alert">
                    ${sessionScope.message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <c:remove var="message" scope="session"/>
        </c:if>

        <!-- Tìm kiếm tên + lọc lớp -->
        <div class="card shadow mb-3">
            <div class="card-body">
                <form class="row g-2 align-items-center" method="get"
                      action="${pageContext.request.contextPath}/students">

                    <!-- Tìm kiếm theo tên -->
                    <div class="col-auto">
                        <div class="input-group input-group-sm">
                            <input type="text" class="form-control" placeholder="Nhập tên sinh viên" name="searchName"
                                   value="${param.searchName}">
                            <button class="btn btn-outline-secondary" type="submit" name="action" value="search">
                                <i class="bi bi-search"></i>
                            </button>
                        </div>
                    </div>

                    <!-- Lọc theo lớp -->
                    <div class="col-auto">
                        <input type="text" class="form-control form-control-sm" placeholder="Tên lớp" name="className"
                               value="${param.className}">
                    </div>
                    <div class="col-auto">
                        <button type="submit" class="btn btn-primary btn-sm"><i class="bi bi-funnel"></i> Lọc</button>
                        <a href="${pageContext.request.contextPath}/students" class="btn btn-secondary btn-sm"><i
                                class="bi bi-arrow-clockwise"></i></a>
                    </div>

                </form>
            </div>
        </div>

        <!-- Danh sách sinh viên -->
        <div class="card shadow">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0 text-center">Danh sách sinh viên</h5>
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
                <!-- Phân trang -->
                <c:if test="${totalPages != null && totalPages > 1}">
                    <nav aria-label="Page navigation">
                        <ul class="pagination justify-content-center mt-2">
                            <c:if test="${currentPage > 1}">
                                <li class="page-item">
                                    <a class="page-link"
                                       href="?page=${currentPage - 1}&className=${param.className}&searchName=${param.searchName}">«
                                        Back</a>
                                </li>
                            </c:if>

                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                    <a class="page-link"
                                       href="?page=${i}&className=${param.className}&searchName=${param.searchName}">${i}</a>
                                </li>
                            </c:forEach>

                            <c:if test="${currentPage < totalPages}">
                                <li class="page-item">
                                    <a class="page-link"
                                       href="?page=${currentPage + 1}&className=${param.className}&searchName=${param.searchName}">Next
                                        »</a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </c:if>

            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
