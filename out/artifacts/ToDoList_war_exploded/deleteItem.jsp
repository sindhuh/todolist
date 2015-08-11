<%@ page import="com.sindhu.webapplication.DeleteItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%int id = Integer.parseInt(request.getParameter("id"));
    DeleteItem.deleteItem(id , String.valueOf(session.getAttribute("username")));%>

