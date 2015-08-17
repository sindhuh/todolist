package com.sindhu.webapplication;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.TimerTask;

public class Timer extends TimerTask {
    static Connection connection = Database.getConnection();
    @Override
    public void run() {

    }
    public static void setTimer(String timerValue, int id) {
        try {
            String update = "UPDATE To_Do_Lists  SET timer='" + timerValue + "' WHERE ID='" + id + "'";
            if (connection == null) {
                return;
            }
            PreparedStatement preparedStatement = connection.prepareStatement(update);
            preparedStatement.executeUpdate(update);
        } catch (SQLException sql) {
            System.out.println("error in sql timer statement : " + sql);
        }
    }
}
