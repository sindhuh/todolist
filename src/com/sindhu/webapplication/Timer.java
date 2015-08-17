package com.sindhu.webapplication;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Timer {
    public static void setTimer(String timerValue, int id) {
        try {
            String update = "UPDATE To_Do_Lists  SET timer='" + timerValue + "' WHERE ID='" + id + "'";
            System.out.println("reached here 1)");
            Connection connection = Database.getConnection();
            if (connection == null) {
                System.out.println("reached here 2)");
                return;
            }
            System.out.println("reached here 3)");
            PreparedStatement preparedStatement = connection.prepareStatement(update);
            System.out.println("reached here 4)");
            preparedStatement.executeUpdate(update);
            System.out.println("reached here 5)");
        } catch (SQLException sql) {
            System.out.println("error in sql timer statement : " + sql);
        }
    }
}
