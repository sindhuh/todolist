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
                <%if (item.timer.equals("")) {%>
                <span id="remainderButton-<%= item.ID %>" class="remainderButtonStyle"
                      value="Remainder"><span class="glyphicon glyphicon-time"></span></span>
                <% } else {%>
                <span class="timeLeftMessageStyle" id="displayTimeId-<%= item.ID %>" style="cursor: pointer"></span>
                <script> getUserTimeData("<%=item.timer %>", <%= item.ID %>);
                </script>
                <% } %>
            </div>
            <%
                }
            %>
        </div>
        <div id="panel" class="panelSlide">
            <div class="timerStyle ">
                <div class="col-sm-5 input-group date datetimepicker">
                    <input id="dateId" type="text" class="form-control"/>
                    <div class="input-group-addon glyphicon glyphicon-calendar"></div>
                </div>
            </div>
            <div class="timerButtons ">
                <div id="cancelButton" class="col-sm-2 btn btn-default">Cancel</div>
                <div id="timeSetButton" style="margin-left: 2%" class="col-sm-2 btn btn-default">Done</div>
            </div>
        </div>
        <div id="resetPanel" class="panelSlide">
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
        $('.datetimepicker').datetimepicker({});
        var timeLeftMessageFunction = function (id) {
            $(id).click(function () {
                var resetPanel = $("#resetPanel");
                resetPanel.insertAfter(this);
                var timeLeft = $(this).html();
                $("#message").html("time remaining: " +timeLeft.split(":").pop());
                resetPanel.slideToggle();
                $("#editButton").click(function () {
                })
            })
        };
        $(".timeLeftMessageStyle").each(function () {
            var idOfTimeLeftMessage = '#' + this.id;
            timeLeftMessageFunction(idOfTimeLeftMessage);
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
    });
</script>
<%@include file="template_footer.html" %>

