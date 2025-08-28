<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Product List</title>
</head>
<body>
<h1>Product List</h1>
<p>
    <a href="${pageContext.request.contextPath}/products?action=create">Create new product</a>
</p>
<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>Name</th>
        <th>Description</th>
        <th>Price</th>
        <th>Edit</th>
        <th>Delete</th>
    </tr>
    <c:forEach items="${products}" var="product">
        <tr>
            <td>
                <a href="${pageContext.request.contextPath}/products?action=view&id=${product.id}">
                        ${product.name}
                </a>
            </td>
            <td>${product.description}</td>
            <td>${product.price}</td>
            <td><a href="${pageContext.request.contextPath}/products?action=edit&id=${product.id}">Edit</a></td>
            <td><a href="${pageContext.request.contextPath}/products?action=delete&id=${product.id}">Delete</a></td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
