package com.sindhu.webapplication;

public class ToDoItem {
    public long ID;
    public String message;
    public String timer;
    public ToDoItem(long ID, String message , String timer) {
        this.ID = ID;
        this.message = message;
        this.timer = timer;
    }
}
