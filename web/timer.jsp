<%@ page import="com.sindhu.webapplication.Timer" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  String timerValue = String.valueOf(request.getParameter("timeDuration"));
  System.out.println("timerValue : " + timerValue);
  int id = Integer.parseInt(request.getParameter("id"));
  Timer.setTimer(timerValue , id);
%>
