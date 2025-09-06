<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sửa thông tin sinh viên</title>
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: #f8f9fa;
            margin-top: 40px;
        }
        .card {
            border-radius: 0.75rem;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0"><i class="bi bi-pencil-square"></i> Sửa thông tin sinh viên</h5>
        </div>
        <div class="card-body">
            <form method="post" action="${pageContext.request.contextPath}/students?action=update"
                  class="row g-3 needs-validation" novalidate>
                <input type="hidden" name="id" value="${student.id}">

                <div class="col-md-6">
                    <label class="form-label">Họ tên sinh viên</label>
                    <input type="text" name="name" class="form-control" value="${student.name}"
                           required minlength="2">
                    <div class="invalid-feedback">Vui lòng nhập tên hợp lệ (ít nhất 2 ký tự).</div>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Ngày sinh</label>
                    <input type="date" name="birthday" class="form-control" value="${student.birthday}" required>
                    <div class="invalid-feedback">Vui lòng chọn ngày sinh.</div>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Địa chỉ</label>
                    <input type="text" name="address" class="form-control" value="${student.address}">
                </div>

                <div class="col-md-6">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" value="${student.email}" required>
                    <div class="invalid-feedback">Vui lòng nhập email hợp lệ.</div>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Số điện thoại</label>
                    <input type="text" name="phone" class="form-control" value="${student.phone}"
                           pattern="^[0-9]{9,11}$" required>
                    <div class="invalid-feedback">Số điện thoại phải có 9-11 chữ số.</div>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Điểm trung bình</label>
                    <input type="number" name="averageGrade" class="form-control" step="0.01"
                           min="0" max="10" value="${student.averageGrade}" required>
                    <div class="invalid-feedback">Điểm phải nằm trong khoảng 0 đến 10.</div>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Tên lớp</label>
                    <input type="text" name="className" class="form-control" value="${student.className}" required>
                    <div class="invalid-feedback">Vui lòng nhập tên lớp.</div>
                </div>

                <div class="col-12 text-center mt-3">
                    <button type="submit" class="btn btn-success">
                        <i class="bi bi-save"></i> Lưu
                    </button>
                    <a href="${pageContext.request.contextPath}/students" class="btn btn-secondary">
                        <i class="bi bi-arrow-left"></i> Quay lại
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Bootstrap client-side validation
    (() => {
        'use strict'
        const forms = document.querySelectorAll('.needs-validation')
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }
                form.classList.add('was-validated')
            }, false)
        })
    })()
</script>
</body>
</html>
