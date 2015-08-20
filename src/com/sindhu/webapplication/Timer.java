package com.sindhu.webapplication;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Timer {
    public static void setTimer(String timerValue, int id) {
        try {
            String update = "UPDATE To_Do_Lists  SET timer='" + timerValue + "' WHERE ID='" + id + "'";
            Connection connection = DatabaseV2.getConnection();
            if (connection == null) {
                return;
            }
            PreparedStatement preparedStatement = connection.prepareStatement(update);
            preparedStatement.executeUpdate(update);
        } catch (SQLException sqle) {
            System.out.println("error in sql timer statement : " + sqle);
        }
    }
}
