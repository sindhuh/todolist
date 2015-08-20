<%@ page import="com.sindhu.webapplication.ToDoList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  int id = Integer.parseInt(request.getParameter("id"));
  String itemName = request.getParameter("itemName");
  ToDoList.updateToDoItem(itemName, id);
%>
