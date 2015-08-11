<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.sindhu.webapplication.Users" %>
<%@include file="template_head.html" %>
<script>
    var errorMessage = ' $("#signUpErrorMessage")';
    <%
      String username = request.getParameter("username");
      String password = request.getParameter("password");
      String firstName = request.getParameter("firstname");
      String lastName = request.getParameter("lastname");
      if((username == null || username == "") || (password== null || password =="") ||
       (firstName == null || firstName == "") || (lastName== null || lastName =="")){
         %>
         errorMessage.text("please fill the details completely");
         <% }
          else {
              Users.insertRecord(firstName, lastName, username, password);
      }
    %>
</script>
<div class="header">
    <div class="title">Sign Up to continue to your To Do List</div>
    <div class="menu">
        <a href="index.jsp" id="login" class="btn btn-primary button">Login</a>
    </div>
</div>
<div id="signUpErrorMessage" class="loginErrorMessage">error</div>
<div class="jumbotron">
    <form action="toDoListSignUp.jsp" class="form-horizontal" role="form" method="post">
        <div class="form-group">
            <label class="control-label col-sm-2" for="pwd">First Name:</label>

            <div class="col-sm-5">
                <input type="text" class="form-control" name="firstname" id="firstname" placeholder="First name">
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-2" for="pwd">Last name:</label>

            <div class="col-sm-5">
                <input type="text" class="form-control" name="lastname" id="lastname" placeholder="Last name">
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-2" for="username">Username:</label>

            <div class="col-sm-5">
                <input type="text" class="form-control" id="username" name="username" placeholder="username">
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-2" for="pwd">Password:</label>

            <div class="col-sm-5">
                <input type="password" class="form-control" name="password" id="pwd" placeholder="Enter password">
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <div class="checkbox">
                    <label><input type="checkbox">Remember me</label>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button type="submit" class="btn btn-primary">Submit</button>
            </div>
        </div>
    </form>
</div>
<div class="col-sm-2">
    Already Registered!
    <a href="index.jsp">Login here</a>
</div>
<%@include file="template_footer.html" %>