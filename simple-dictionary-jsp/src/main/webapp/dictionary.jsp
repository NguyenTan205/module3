<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Simple Dictionary</title>
</head>
<body>
<%!
    Map<String, String> dic = new HashMap<>();
%>

<%
    dic.put("hello", "Xin chao");
    dic.put("book", "Quyen sach");
    String search = request.getParameter("search");
    String result = dic.get(search);
    if (result != null) {
        out.println("word: " + search);
        out.println("result: " + result);
    } else {
        out.println("not found");
    }
%>
</body>
</html>