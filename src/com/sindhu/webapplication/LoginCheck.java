package com.sindhu.webapplication;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet("/LoginCheck")
public class LoginCheck extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        String username = request.getParameter("name");
        String password = request.getParameter("password");
        boolean checkUser ;
        try {
            String query = "SELECT username, password FROM User_Accounts WHERE username=" + "'" + username + "'" + "AND password=" + "'" + password + "'";
            Connection connection = Database.getConnection();
            if (connection == null) {
                return;
            }
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            if (resultSet.next()) {
                checkUser = resultSet.getString(1).equals(username) && resultSet.getString(2).equals(password);
                if(checkUser){
                        response.setContentType("text/plain");
                        response.getWriter().write("successful");
                }else{
                    response.setContentType("text/plain");
                    response.getWriter().write("invalid");
                }
            }
        } catch (SQLException sql) {
            System.out.println("Error in sql statement :" + sql.getMessage());
        }
        catch (IOException e) {
            e.printStackTrace();
        }
    }
}

