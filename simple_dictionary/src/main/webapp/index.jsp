<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>simple dictionary</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
<h2>Vietnamese Dictionary</h2>
<form action="${pageContext.request.contextPath}/translate" method="post">
    <input type="text" name="txtSearch" placeholder="Enter your word: "/>
    <input type = "submit" id = "submit" value = "Search"/>
</form>
</body>
</html>