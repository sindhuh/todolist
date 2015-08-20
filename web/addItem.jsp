<%@ page import="com.sindhu.webapplication.ToDoList" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String toDoItem = request.getParameter("item");
  if(session.getAttribute("username") == null){
    return;
  }
  ToDoList.addToDoItem(String.valueOf(session.getAttribute("username")), toDoItem);
  long last_id = ToDoList.toDoListLastId();
  response.getWriter().write(String.valueOf(last_id));
%>