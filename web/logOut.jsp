<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="template_head.html"%>
<% session.setAttribute("name" , null);
  session.invalidate();
  response.sendRedirect("index.jsp");
%>
<%@include file="template_footer.html"%>
