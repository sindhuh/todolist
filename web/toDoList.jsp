<%@ page import="java.util.List" %>
<%@ page import="com.sindhu.webapplication.ToDoList" %>
<%@ page import="com.sindhu.webapplication.ToDoItem" %>
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
        <div id="listBody" class="toDoListStyle">
            <%
                for (ToDoItem item : toDoListItems) {
            %>
            <div id="listItemId-<%= item.ID %>" class="toDoListDataStyle">
                <span id="item-<%= item.ID %>" class="itemStyle " contenteditable="true"><%= item.message %>
                </span>
                <span class="checkboxStyle checkbox-primary" id="checkboxId-<%= item.ID %>"><input class="checkboxSize"
                                                                                                   type="checkbox"/></span>
                    <span style="display: none" id="remainderButton-<%= item.ID %>" class="remainderButtonStyle"
                          value="Remainder"><span class="glyphicon glyphicon-time"></span></span>
                <span id="displayTimeId-<%= item.ID %>" style="cursor: pointer; display: none"></span>
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
        <%
         for(ToDoItem item : toDoListItems){
            if(item.timer.equals("")) { %>
                $("#remainderButton-<%= item.ID %>").css("display", "block");
            <% } else { %>
                $("#displayTimeId-<%= item.ID %>").css("display", "block");
                getUserTimeData("<%=item.timer %>" , <%= item.ID %>);
                console.log("timer value : " + "<%=item.timer%>");
        <%  }
        }
        %>
        $('.datetimepicker').datetimepicker({});
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
    });
</script>
<%@include file="template_footer.html" %>

