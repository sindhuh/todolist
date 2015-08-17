package com.sindhu.webapplication;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UpdateItem {

    public static void updateItem(String itemName , int id) {
        try {
            String update = "UPDATE To_Do_Lists  SET toDoItem='" +itemName +"' WHERE ID='" +id + "'";
            Connection connection = Database.getConnection();
            if (connection == null) {
                return;
            }
            PreparedStatement preparedStatement = connection.prepareStatement(update);
            preparedStatement.executeUpdate(update);
        }
        catch (SQLException sql){
            System.out.println("error in sql statement :" +sql);
        }
    }
}
