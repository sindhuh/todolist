<%@ page import="com.sindhu.webapplication.Users" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<%
  String username = request.getParameter("username");
  String password = request.getParameter("password");
  String firstName = request.getParameter("firstname");
  String lastName = request.getParameter("lastname");
  if (!(username.isEmpty()) && !(password.isEmpty())
          && !(firstName.isEmpty()) && !(lastName.isEmpty())) {
    Users.insertRecord(firstName, lastName, username, password);
    out.print("Registration Successful");
  }
  else if (username.isEmpty() && !(password.isEmpty())
          && !(firstName.isEmpty()) && !(lastName.isEmpty())) {
    out.print("field username cannot be empty");
  }
  else if (!(username.isEmpty()) && password.isEmpty()
          && !(firstName.isEmpty()) && !(lastName.isEmpty()))
  {
    out.print("field password cannot be empty");
  }
  else if (!(username.isEmpty()) && !(password.isEmpty())
          && firstName.isEmpty() && !(lastName.isEmpty()))
  {
    out.print("field first name cannot be empty");
  }
  else if(!(username.isEmpty()) && !(password.isEmpty())
          && !(firstName.isEmpty()) && lastName.isEmpty()) {
      out.print("field last name cannot be empty");
    }
  else {
      out.print("Please enter valid details");
    }
%>
<br>
<a href="toDoList.jsp" class="btn btn-primary">Login here</a>
</body>
</html>
