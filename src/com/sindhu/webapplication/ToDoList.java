package com.sindhu.webapplication;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ToDoList {
    public static long toDoListLastId() {
        long lastID = 0;
        try {
            String query = "SELECT MAX(id) as last_id FROM To_Do_Lists";
            Connection connection = DatabaseV2.getConnection();
            if (connection == null) {
                return 0 ;
            }
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            if(resultSet.next()) {
                lastID = resultSet.getLong("last_id");
            }
            connection.close();
        } catch (SQLException sqle) {
            System.out.println("Error in sql statement sin:" + sqle.getMessage());
        }
        return lastID;
    }

    public static List<ToDoItem> toDoListItems(String username) {
        List<ToDoItem> toDoList = new ArrayList<>();
        try {
            String query = "SELECT ID, toDoItem, timer FROM To_Do_Lists WHERE username=" + "'" + username + "'";
            Connection connection = DatabaseV2.getConnection();
            if (connection == null) {
                return toDoList;
            }
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
                String timerValue = resultSet.getString("timer");
                if (resultSet.wasNull()) {
                    toDoList.add(new ToDoItem(resultSet.getLong("ID"), resultSet.getString("toDoItem"), ""));
                } else {
                    toDoList.add(new ToDoItem(resultSet.getLong("ID"), resultSet.getString("toDoItem"), timerValue));
                }
            }
            connection.close();
        }
        catch (SQLException sql) {
            System.out.println("Error in sql statement :" + sql.getMessage());
        }
        return toDoList;
    }

    public static void addToDoItem(String username, String addItem) {
        try {
            String insert = "INSERT INTO To_Do_Lists(username , toDoItem)" +
                    "VALUES (?, ?)";
            Connection connection = DatabaseV2.getConnection();
            if (connection == null) {
                return;
            }
            PreparedStatement ps = connection.prepareStatement(insert);
            ps.setString(1, username);
            ps.setString(2, addItem);
            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated == 1) {
                connection.close();
                return;
            }
            connection.close();
        } catch (SQLException sql) {
            System.out.println("Error in sql statement :" + sql.getMessage());
        }
    }
    public static void updateToDoItem(String itemName, int id) {
        try {
            String update = "UPDATE To_Do_Lists  SET toDoItem='" +itemName +"' WHERE ID='" +id + "'";
            Connection connection = DatabaseV2.getConnection();
            if (connection == null) {
                return;
            }
            PreparedStatement preparedStatement = connection.prepareStatement(update);
            int rowsUpdated = preparedStatement.executeUpdate(update);
            if(rowsUpdated == 1){
                connection.close();
                return;
            }
            connection.close();
        }
        catch (SQLException sql){
            System.out.println("error in sql statement :" +sql);
        }
    }
}



