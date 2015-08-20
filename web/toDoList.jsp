<%@ page import="com.sindhu.webapplication.ToDoItem" %>
<%@ page import="com.sindhu.webapplication.ToDoList" %>
<%@ page import="java.util.List" %>
<%@include file="toDoList_head.html" %>
<%
    if (session.getAttribute("username") == null || session.getAttribute("username") == "") {
        return;
    }
%>
<%!
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
        <div id="addItemFailAlert" class="alert alert-danger" style="display: none">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            <strong>Sorry!</strong>Please try again.
        </div>
        <div id="listBody" class="toDoList">
            <%
                for (ToDoItem item : toDoListItems) {
            %>
            <div id="listItemId-<%= item.ID %>" class="toDoListItem">
                <span id="item-<%= item.ID %>" class="itemStyle " contenteditable="true"><%= item.message %>
                </span>
                <span class="checkboxStyle checkbox-primary" id="checkboxId-<%= item.ID %>"><input class="checkboxSize"
                                                                                                   type="checkbox"/></span>
                <%if ((item.timer).trim().isEmpty()) {%>
                <span id="remainderButton-<%= item.ID %>" class="remainderButton"
                      value="Remainder"><span class="glyphicon glyphicon-time"></span></span>
                <% } else {%>
                <span class="timeLeftMessageStyle" id="displayTimeId-<%= item.ID %>" style="cursor: pointer"></span>
                <% } %>
            </div>
            <%
                }
            %>
        </div>
        <div id="setTimerPanel" class="panelSlide">
            <div class="timerStyle">
                <div class="col-sm-5 input-group date datetimepicker">
                    <input id="dateId" type="text" class="form-control"/>
                    <div class="input-group-addon glyphicon glyphicon-calendar"></div>
                </div>
            </div>
            <div class="timerButtons ">
                <div id="cancelButton" class="col-sm-2 btn btn-link">Cancel</div>
                <div id="timeSetButton" style="margin-left: 2%" class="col-sm-2 btn btn-primary">Done</div>
            </div>
        </div>
        <div id="updateTimerPanel" class="panelSlide">
            <div id="message"></div>
            <div class="col-sm-5 input-group date datetimepicker">
                <input id="dateI" type="text" class="form-control"/>
                <div class="input-group-addon glyphicon glyphicon-calendar"></div>
            </div>
            <div id="editButton" class="btn btn-primary">Edit</div>
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
        var setupTimeLeftButton = function (id) {
            $(id).click(function () {
                var resetPanel = $("#updateTimerPanel");
                resetPanel.insertAfter(this);
                var timeLeft = $(this).html();
                $("#message").html("time remaining: " + timeLeft.split(":").pop());
                resetPanel.slideToggle();
                $("#editButton").click(function () {
                    resetPanel.css("display", "none");
                    var element = $("#listItemId-" + id.split("-").pop());
                    var setTimerPanel = $("#setTimerPanel");
                    setTimerPanel.insertAfter(element);
                    setTimerPanel.slideDown();
                    $("#cancelButton").click(function () {
                        reminderCancelFunction();
                    });
                    $("#timeSetButton").click(function () {
                        reminderSetFunction(id.split("-").pop());
                    });
                });
            })
        };
        $(".timeLeftMessageStyle").each(function () {
            var idOfTimeLeftMessage = '#' + this.id;
           <% for (ToDoItem item : toDoListItems) { %>
            if(this.id.split("-").pop() == <%= item.ID %> ) {
                getUserTimeData("<%= item.timer%>" , <%= item.ID%>);
            }
            <% } %>
            setupTimeLeftButton(idOfTimeLeftMessage);
        });
        $(".remainderButton").each(function () {
            var idOfRemainder = '#' + this.id;
            setUpReminderButton(idOfRemainder);
        });
        var listEmpty = <%=isListEmpty%>;
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
                    var idOfLastItem;
                    idOfLastItem = parseInt(data);
                    var insertRow = "<div class='toDoListDataStyle' id='listItemId-" + idOfLastItem + "'><span contenteditable='true' id='item-" + idOfLastItem + "' class ='itemStyle'>" + itemName + " </span><span class='checkboxStyle' id='checkboxId-" + idOfLastItem + "' ><input class='checkboxSize' type='checkbox'/></span><span id='remainderButton-" + idOfLastItem + "' class='button btn btn-default btn-sm remainderButton'>Reminder</span></div>";
                    if (listEmpty) {
                        listEmpty = false;
                        $('#listBody').prepend(insertRow);
                    } else {
                        $('#listBody').last().append(insertRow);
                    }
                    setUpClickListeners("#listItemId-" + idOfLastItem);
                    updateItemFunction("#item-" + idOfLastItem);
                    setUpReminderButton("#remainderButton-" + idOfLastItem);
                    itemInputNode.val("");
                }).fail(function () {
                    $('#addItemFailAlert').css("display","block");
                });
            }
        });
        var setUpClickListeners = function (Id) {
            mouseEventFunction(Id);
            deleteFunction(Id , listEmpty);
        }
        $('.itemStyle').each(function () {
            updateItemFunction('#' + this.id);
        });
        $('.toDoListItem').each(function () {
            setUpClickListeners('#' + this.id);
        });
        $('.datetimepicker').datetimepicker({
            'sideBySide' : true
        });
    });
</script>
<%@include file="template_footer.html" %>

