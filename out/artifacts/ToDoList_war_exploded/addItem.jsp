<%@ page import="com.sindhu.webapplication.ToDoList" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String toDoItem = request.getParameter("item");
  if(session.getAttribute("username") == null){
    return;
  }
  ToDoList.addItem(String.valueOf(session.getAttribute("username")), toDoItem);
  List<Long> toDoItemsIds = ToDoList.toDoListIds();
  long lastItemIdOfList = toDoItemsIds.get(toDoItemsIds.size() - 1);
  response.getWriter().write(String.valueOf(lastItemIdOfList));
%>