<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Thêm sinh viên mới</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background: url('https://images.unsplash.com/photo-1522075469751-3a6694fb2f61?auto=format&fit=crop&w=1920&q=80')
            no-repeat center center fixed;
            background-size: cover;
            min-height: 100vh;
        }
        .form-box {
            background: rgba(255, 255, 255, 0.95);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.3);
            max-width: 600px;
            width: 100%;
        }
    </style>
</head>
<body class="d-flex justify-content-center align-items-center">

<div class="form-box">
    <h2 class="text-center mb-4 text-primary">
        <i class="bi bi-person-plus-fill"></i> Thêm sinh viên mới
    </h2>

    <form method="post" action="${pageContext.request.contextPath}/students?action=create"
          class="needs-validation" novalidate>
        <!-- Họ tên -->
        <div class="mb-3">
            <label class="form-label">Họ tên</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
                <input type="text" name="name" id="name" class="form-control"
                       placeholder="Họ tên sinh viên" required minlength="2">
                <div class="invalid-feedback">Tên phải có ít nhất 2 ký tự.</div>
            </div>
        </div>

        <!-- Ngày sinh -->
        <div class="mb-3">
            <label class="form-label">Ngày sinh</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-calendar-date-fill"></i></span>
                <input type="date" name="birthday" id="birthday" class="form-control" required>
                <div class="invalid-feedback">Vui lòng chọn ngày sinh hợp lệ.</div>
            </div>
        </div>

        <!-- Địa chỉ -->
        <div class="mb-3">
            <label class="form-label">Địa chỉ</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-geo-alt-fill"></i></span>
                <input type="text" name="address" id="address" class="form-control"
                       placeholder="Địa chỉ" required>
                <div class="invalid-feedback">Vui lòng nhập địa chỉ.</div>
            </div>
        </div>

        <!-- Email -->
        <div class="mb-3">
            <label class="form-label">Email</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-envelope-fill"></i></span>
                <input type="email" name="email" id="email" class="form-control"
                       placeholder="Email" required>
                <div class="invalid-feedback">Email không hợp lệ.</div>
            </div>
        </div>

        <!-- Số điện thoại -->
        <div class="mb-3">
            <label class="form-label">Số điện thoại</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-telephone-fill"></i></span>
                <input type="text" name="phone" id="phone" class="form-control"
                       placeholder="Số điện thoại" pattern="^[0-9]{9,11}$" required>
                <div class="invalid-feedback">Số điện thoại phải có 9–11 chữ số.</div>
            </div>
        </div>

        <!-- Điểm trung bình -->
        <div class="mb-3">
            <label class="form-label">Điểm trung bình</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-star-fill"></i></span>
                <input type="number" step="0.01" name="averageGrade" id="averageGrade"
                       class="form-control" placeholder="Điểm trung bình" min="0" max="10" required>
                <div class="invalid-feedback">Điểm phải nằm trong khoảng 0–10.</div>
            </div>
        </div>

        <!-- Tên lớp -->
        <div class="mb-3">
            <label class="form-label">Tên lớp</label>
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-building"></i></span>
                <input type="text" name="className" id="className" class="form-control"
                       placeholder="Tên lớp" required>
                <div class="invalid-feedback">Vui lòng nhập tên lớp.</div>
            </div>
        </div>

        <!-- Buttons -->
        <div class="d-flex justify-content-between">
            <a href="${pageContext.request.contextPath}/students" class="btn btn-secondary">
                <i class="bi bi-arrow-left-circle"></i> Quay lại
            </a>
            <button type="submit" class="btn btn-success">
                <i class="bi bi-save-fill"></i> Lưu
            </button>
        </div>
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Bootstrap validation
    (() => {
        'use strict'
        const forms = document.querySelectorAll('.needs-validation')
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                // validate ngày sinh không được lớn hơn ngày hiện tại
                const birthday = form.querySelector('#birthday')
                if (birthday && birthday.value) {
                    const today = new Date().toISOString().split("T")[0]
                    if (birthday.value > today) {
                        birthday.setCustomValidity("Ngày sinh không được lớn hơn hôm nay")
                    } else {
                        birthday.setCustomValidity("")
                    }
                }

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
