package com.sindhu.webapplication;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class DeleteItem {
    public static void deleteItem(int id , String username) {
        try {
            String delete = "DELETE from To_Do_Lists WHERE id = ? AND username = ?";
            Connection connection = Database.getConnection();
            if (connection == null) {
                return;
            }
            PreparedStatement preparedStatement = connection.prepareStatement(delete);
            preparedStatement.setInt(1, id);
            preparedStatement.setString(2, username);
            int rowsUpdated = preparedStatement.executeUpdate();
            if(rowsUpdated==1){
                return;
            }
            connection.close();

        } catch (Exception ex) {
            System.out.print("SQL Exception" +ex);
        }
    }
    }

