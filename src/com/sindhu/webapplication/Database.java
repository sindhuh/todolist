package com.sindhu.webapplication;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {
    private static final String CONNECTION_URL = "jdbc:mysql://127.0.0.1/toDoList";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "hari1993";

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection connection = DriverManager.getConnection(CONNECTION_URL, USERNAME, PASSWORD);
            if (!connection.isClosed()) {
                return connection;
            } else {
                System.out.println("Failed to connect.");
            }
        } catch (ClassNotFoundException | IllegalAccessException | InstantiationException cnfe) {
            System.out.println("Couldn't instantiate JDBC Driver " + cnfe.getMessage());
        } catch (SQLException sqle) {
            System.out.println("Got an error while opening the connection " + sqle.getMessage());
        }
        return null;
    }
}
