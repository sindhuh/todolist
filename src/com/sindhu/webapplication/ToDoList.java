package com.sindhu.webapplication;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ToDoList {
    public static List<Long> toDoListIds() {
        List<Long> toDoListIds = new ArrayList<>();
        try {
            String query = "SELECT ID, toDoItem FROM To_Do_Lists";
            Connection connection = Database.getConnection();
            if (connection == null) {
                return toDoListIds;
            }
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
                toDoListIds.add(resultSet.getLong(1));
            }
        } catch (SQLException sql) {
            System.out.println("error");
            System.out.println("Error in sql statement :" + sql.getMessage());
        }
        return toDoListIds;
    }

    public static List<ToDoItem> toDoListItems(String username) {
        List<ToDoItem> toDoList = new ArrayList<>();
        try {
            String query = "SELECT ID, toDoItem, timer FROM To_Do_Lists WHERE username=" + "'" + username + "'";
            Connection connection = Database.getConnection();
            if (connection == null) {
                return toDoList;
            }
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
                resultSet.getString("timer");
                resultSet.wasNull();
                if (resultSet.wasNull()) {
                    toDoList.add(new ToDoItem(resultSet.getLong("ID"), resultSet.getString("toDoItem"), ""));
                } else {
                    toDoList.add(new ToDoItem(resultSet.getLong("ID"), resultSet.getString("toDoItem"), resultSet.getString("timer")));
                }
            }
        } catch (SQLException sql) {
            System.out.println("Error in sql statement :" + sql.getMessage());
        }
        return toDoList;
    }

    public static void addItem(String username, String addItem) {
        try {
            String insert = "INSERT INTO To_Do_Lists(username , toDoItem)" +
                    "VALUES (?, ?)";
            Connection connection = Database.getConnection();
            if (connection == null) {
                return;
            }
            PreparedStatement ps = connection.prepareStatement(insert);
            ps.setString(1, username);
            ps.setString(2, addItem);
            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated == 1) {
                return;
            }
            connection.close();
        } catch (SQLException sql) {
            System.out.println("Error in sql statement :" + sql.getMessage());
        }
    }
}



