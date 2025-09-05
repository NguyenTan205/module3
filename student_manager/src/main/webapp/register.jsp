<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Đăng ký</title>
  <!-- Bootstrap 5 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
  <style>
    body {
      font-family: Arial, sans-serif;
      background: url('https://images.unsplash.com/photo-1503676260728-1c00da094a0b?auto=format&fit=crop&w=1920&q=80')
      no-repeat center center fixed;
      background-size: cover;
      height: 100vh;
    }
    .register-box {
      background: rgba(255,255,255,0.9);
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 4px 15px rgba(0,0,0,0.3);
      width: 100%;
      max-width: 420px;
    }
    .extra-links a {
      display: block;
      margin-top: 10px;
      font-size: 0.95rem;
      text-decoration: none;
      transition: 0.2s;
    }
    .extra-links a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body class="d-flex justify-content-center align-items-center">

<div class="register-box">
  <h2 class="text-center mb-4">
    <i class="bi bi-person-plus-fill text-success"></i> Đăng ký tài khoản
  </h2>

  <!-- Hiển thị lỗi -->
  <c:if test="${not empty error}">
    <div class="alert alert-danger text-center" role="alert">
      <i class="bi bi-exclamation-triangle-fill"></i> ${error}
    </div>
  </c:if>

  <!-- Hiển thị thông báo -->
  <c:if test="${not empty message}">
    <div class="alert alert-success text-center" role="alert">
      <i class="bi bi-check-circle-fill"></i> ${message}
    </div>
  </c:if>

  <!-- Form đăng ký -->
  <form action="${pageContext.request.contextPath}/register" method="post">
    <!-- Username -->
    <div class="mb-3 input-group">
      <span class="input-group-text"><i class="bi bi-person-fill"></i></span>
      <input type="text" name="username" class="form-control" placeholder="Tên đăng nhập" required />
    </div>

    <!-- Password -->
    <div class="mb-3 input-group">
      <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
      <input type="password" id="password" name="password" class="form-control" placeholder="Mật khẩu" required />
      <button type="button" class="btn btn-outline-secondary" onclick="togglePassword()">
        <i class="bi bi-eye-fill" id="toggleIcon"></i>
      </button>
    </div>

    <button type="submit" class="btn btn-success w-100">
      <i class="bi bi-person-check-fill"></i> Đăng ký
    </button>
  </form>

  <!-- Link bổ sung -->
  <div class="extra-links text-center mt-3">
    <a href="${pageContext.request.contextPath}/login" class="text-primary">
      <i class="bi bi-box-arrow-in-right"></i> Đăng nhập
    </a>
    <a href="${pageContext.request.contextPath}/home" class="text-secondary">
      <i class="bi bi-house-door-fill"></i> Về trang chủ
    </a>
  </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
  function togglePassword() {
    const passwordInput = document.getElementById("password");
    const toggleIcon = document.getElementById("toggleIcon");
    if (passwordInput.type === "password") {
      passwordInput.type = "text";
      toggleIcon.classList.remove("bi-eye-fill");
      toggleIcon.classList.add("bi-eye-slash-fill");
    } else {
      passwordInput.type = "password";
      toggleIcon.classList.remove("bi-eye-slash-fill");
      toggleIcon.classList.add("bi-eye-fill");
    }
  }
</script>
</body>
</html>
