<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Trang chủ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Lobster&display=swap" rel="stylesheet">
    <style>
        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: url('https://images.unsplash.com/photo-1523580846011-d3a5bc25702b') no-repeat center center/cover;
        }
        .overlay {
            background-color: rgba(255, 255, 255, 0.85);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.2);
        }
        h1 {
            font-family: 'Lobster', cursive;
            font-size: 3rem;
            color: #ff5722;
        }
    </style>
</head>
<body>

<div class="overlay text-center">
    <h1 class="mb-4">Chào mừng đến với Student Manager</h1>
    <p class="mb-4 text-secondary">Vui lòng chọn chức năng:</p>

    <div class="d-flex justify-content-center gap-3">
        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-lg px-4">Đăng nhập</a>
        <a href="${pageContext.request.contextPath}/register" class="btn btn-success btn-lg px-4">Đăng ký</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
