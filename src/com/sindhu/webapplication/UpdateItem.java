package com.sindhu.webapplication;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class UpdateItem {

    public static void updateItem(String itemName , int id) {
        try {
            String update = "UPDATE To_Do_Lists  SET toDoItem='" +itemName +"' WHERE ID='" +id + "'";
            Connection connection = Database.getConnection();
            if (connection == null) {
                return;
            }
            Statement statement = connection.createStatement();
            statement.executeUpdate(update);
        }
        catch (SQLException sql){
            System.out.println("error in sql statement :" +sql);
        }
    }
}
