<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<center>
    <h1>Quản lí sinh viên</h1>
</center>
<div align="center">
    <form method="post" action="${pageContext.request.contextPath}/students?action=update">
        <table border="1" cellpadding="5">
            <caption>
                <h2>Sửa thông tin sinh viên</h2>
            </caption>
            <c:if test="${existingStudent != null}">
                <input type="hidden" name="id" value="${existingStudent.id}">
            </c:if>
            <tr>
                <th>Họ tên sinh viên:</th>
                <td>
                    <input type="text" name="name" size="45" value="${existingStudent.name}">
                </td>
            </tr>
            <tr>
                <th>Ngày sinh:</th>
                <td>
                    <input type="text" name="birthday" size="45" value="${existingStudent.birthday}">
                </td>
            </tr>
            <tr>
                <th>Địa chỉ:</th>
                <td>
                    <input type="text" name="address" size="45" value="${existingStudent.address}">
                </td>
            </tr>
            <tr>
                <th>Email:</th>
                <td>
                    <input type="text" name="email" size="45" value="${existingStudent.email}">
                </td>
            </tr>
            <tr>
                <th>Số điện thoại:</th>
                <td>
                    <input type="text" name="phone" size="45" value="${existingStudent.phone}">
                </td>
            </tr>
            <tr>
                <th>Điểm trung bình: </th>
                <td>
                    <input type="number" name="averageGrade" size="45" value="${existingStudent.averageGrade}">
                </td>
            </tr>
            <tr>
                <th>Tên lớp: </th>
                <td>
                    <input type="text" name="className" size="45" value="${existingStudent.className}">
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="Lưu">
                </td>
            </tr>
        </table>
    </form>
</div>
<center>
    <h2>
        <a href="${pageContext.request.contextPath}/students">Back</a>
    </h2>
</center>
</body>
</html>
