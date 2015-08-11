<%@ page import="com.sindhu.webapplication.Users" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="template_head.html" %>
<script>
    $(function(){
    var errorMessage = $('#errorMessage');
       errorMessage.css("display" , "none");
    <%if(session.getAttribute("username") != null){
    response.sendRedirect("toDoList.jsp");
    }%>
    <%
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        if(Users.login(username , password)) {
            session.setAttribute("username", username);
            response.sendRedirect("toDoList.jsp");
        }
        else {
            if((username == null || username == "") || (password== null || password =="")){
            } else {%>
        errorMessage.css("display" , "block");
        <% } } %>
    });
</script>
<div class="header">
    <div class="title">Sign in to continue to your To Do List</div>
    <div class="menu">
        <a href="toDoListSignUp.jsp" id="signup" class="btn btn-primary button" role="button" value="signup">Sign Up</a>
    </div>
</div>
<div id="errorMessage" class="loginErrorMessage">invalid username or password</div>
<div class="jumbotron">
    <form action="index.jsp" method="post" class="form-horizontal" role="form">
        <div class="form-group">
            <label class="control-label col-sm-2" for="username">Username:</label>

            <div class="col-sm-5">
                <input type="text" class="form-control" id="username" name="username" placeholder="Enter email">
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
                    <label><input type="checkbox"> Remember me</label>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <button id="submitButton" type="submit" class="btn btn-primary">Login</button>
            </div>
        </div>
    </form>
</div>
<%@include file="template_footer.html" %>