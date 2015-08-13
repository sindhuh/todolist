<%@ page import="java.util.List" %>
<%@ page import="com.sindhu.webapplication.ToDoList" %>
<%@ page import="com.sindhu.webapplication.ToDoItem" %>
<%@ include file="jsFiles.html" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
    <link href="css/ToDoListStyleSheet.css" rel="stylesheet">
</head>
<body>
<script type="text/javascript" src="js/jquery-2.1.4.js"></script>
<script type="text/javascript" src="js/moment.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="js/bootbox.min.js"></script>

<nav class="navbar navbar-inverse ">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <div class="navbar-brand">Welcome <%=session.getAttribute("username")%>! your to do list.
            </div>
        </div>
        <form class="nav navbar-nav navbar-right navbar-form">
            <div class="form-group">
                <a href="logOut.jsp" id="" class="btn  btn-primary">Log out</a>
            </div>
        </form>
    </div>
</nav>
<div class="container">
        <%
    if (session.getAttribute("username") == null || session.getAttribute("username") == "") {
        return;
    }
%>
        <%!
    long lastMessageId = 0;
    boolean isListEmpty = false;
%>
        <%
    List<ToDoItem> toDoListItems = ToDoList.toDoListItems(String.valueOf(session.getAttribute("username")));
    isListEmpty = toDoListItems.isEmpty();
%>
        <%if (isListEmpty) {%>
    <div id="emptyListMessage" class="listEmptyMessage">Your To Do List is empty</div>
        <%}%>

    <div class="toDoListContainerOuter">
        <div id="listContainer" class="toDoListContainerInner">
            <div id="listBody" class="toDoListStyle">
                <%
                    for (ToDoItem item : toDoListItems) {
                %>
                <div id="listItemId-<%= item.ID %>" class="toDoListDataStyle">
                <span id="item-<%= item.ID %>" class="itemStyle " contenteditable="true"><%= item.message %>
                </span>
                <span class="checkboxStyle checkbox-primary" id="checkboxId-<%= item.ID %>"><input class="checkboxSize"
                                                                                                   type="checkbox"/></span>
                <span id="remainderButton-<%= item.ID %>" class="remainderButtonStyle"
                      value="Remainder"><span class="glyphicon glyphicon-time"></span>
                    <span id="displayTimeId-<%= item.ID %>" style="display : none"></span>
                </span>
                </div>
                <div id="panel-<%= item.ID %>" class="panelSlide">
                    <div class="timerStyle ">
                        <div class="col-sm-5 input-group date datetimepicker">
                            <input id="dateId-<%= item.ID %>" type="text" class="form-control"/>
                            <div class="input-group-addon glyphicon glyphicon-calendar"></div>
                        </div>
                    </div>
                    <div class="timerButtons ">
                        <div id="cancelButton-<%= item.ID %>" class="col-sm-2 btn btn-default">Cancel</div>
                        <div id="timeSetButton-<%= item.ID %>" class="col-sm-2 btn btn-default">Done</div>
                    </div>
                </div>
                <%
                        lastMessageId = item.ID;
                    }
                %>
            </div>
            <div class="inputTextOuter">
                <div class="col-sm-5 inputTextInner">
                    <input type="text" class="form-control" id="todoItemName"
                           placeholder="Your To-Do goes here.."/>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(function () {
            $('.datetimepicker').datetimepicker({
            });
            $(".remainderButtonStyle").each(function () {
                var idOfRemainder = '#' + this.id;
                reminderFunction(idOfRemainder);
            });
            var listEmpty = <%=isListEmpty%>;
            var idOfLastItem = 0;
            $(".checkboxStyle").css('visibility', 'hidden');
            var itemInputNode = $('#todoItemName');
            itemInputNode.keypress(function (e) {
                if (e.which == 13) {
                    var itemName = itemInputNode.val();
                    if (!itemName.trim()) {
                        return;
                    }
                    $('#emptyListMessage').css("display", "none");
                    $.ajax({
                        url: 'addItem.jsp',
                        data: {
                            item: itemName,
                        },
                        method: 'POST'
                    }).done(function (data) {
                        idOfLastItem = parseInt(data);
                        if (listEmpty) {
                            listEmpty = false;
                            $('#listBody').prepend("<div class='toDoListDataStyle' id='listItemId-" + idOfLastItem + "'><span contenteditable='true' id='item-" + idOfLastItem + "' class ='itemStyle'>" + itemName + " </span><span class='checkboxStyle' id='checkboxId-" + idOfLastItem + "' ><input type='checkbox'/></span><span id='remainderButton-" + idOfLastItem + "' class='button btn btn-default btn-sm remainderButtonStyle'>Reminder</span></div>");
                            $('#checkboxId-' + idOfLastItem).css('visibility', 'hidden');
                        } else {
                            $('#listBody').last().append("<div class='toDoListDataStyle' id='listItemId-" + idOfLastItem + "'> <span contenteditable='true' id='item-" + idOfLastItem + "' class ='itemStyle'>" + itemName + " </span><span class='checkboxStyle' id='checkboxId-" + idOfLastItem + "' ><input type='checkbox'/></span><span id='remainderButton-" + idOfLastItem + "' class='button btn btn-default btn-sm remainderButtonStyle'>Reminder</span></div>");
                            $('#checkboxId-' + idOfLastItem).css('visibility', 'hidden');
                        }
                        setUpClickListeners("#listItemId-" + idOfLastItem);
                        updateItemFunction("#item-" + idOfLastItem);
                        reminderFunction("#remainderButton-" + idOfLastItem);
                    }).fail(function () {
                    });
                    itemInputNode.val("");
                }
            });
            var setUpClickListeners = function (Id) {
                mouseEventFunction(Id);
                deleteFunction(Id);
                if (($('#listBody').children().length) == 0) {
                    listEmpty = true;
                    $('#emptyListMessage').css("display", "block");
                }
            }
            $('.itemStyle').each(function () {
                updateItemFunction('#' + this.id);
            });
            $('.toDoListDataStyle').each(function () {
                setUpClickListeners('#' + this.id);
            });
        })
    </script>
    <%@include file="template_footer.html" %>

