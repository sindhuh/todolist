package com.sindhu.webapplication;

import java.sql.*;

public class Users {
    public static boolean insertRecord(String firstname, String lastname, String username, String password) {
        try {
            String insert = "INSERT INTO User_Accounts(Username, password , First_Name, Last_Name)" +
                    "VALUES (?, ?,?,?)";
            Connection connection = Database.getConnection();
            if (connection == null) {
                return false;
            }
            PreparedStatement ps = connection.prepareStatement(insert);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, firstname);
            ps.setString(4, lastname);
            int rowsUpdated = ps.executeUpdate();
            connection.close();
            return rowsUpdated == 1;
        } catch (SQLException sql) {
            System.out.println("Error in sql statement :" + sql.getMessage());
        }
        return false;
    }
    public static boolean login(String username, String password){
        boolean checkUser = false;
        try {
            String query = "SELECT username, password FROM User_Accounts WHERE username="+"'"+username+"'" +"AND password=" +"'"+password+"'";
            Connection connection = Database.getConnection();
            if (connection == null) {
                return false;
            }
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            if(resultSet.next()){
                checkUser = resultSet.getString(1).equals(username) && resultSet.getString(2).equals(password);
            }
        }
        catch (SQLException sql) {
            System.out.println("Error in sql statement :" + sql.getMessage());
        }
        return checkUser;
    }
}
