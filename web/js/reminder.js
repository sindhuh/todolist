var reminderCancelFunction = function(){
    $('.remainderButtonStyle').css("pointer-events","auto");
    $('#dateId').val("");
    $("#panel").slideUp("slow");
}
var reminderSetFunction = function(id) {
    $('.remainderButtonStyle').css("pointer-events","auto");
    var dateAndTime = $("#dateId").val();
    $("#panel").slideUp("slow");
    if (!dateAndTime.trim()) {
        return;
    }
    else {
        $.ajax({
            url: "timer.jsp",
            data: {
                timeDuration: dateAndTime,
                id: id,
            },
            method: "POST"
        }).done(function () {
        }).fail(function () {
        });
    }
    getUserTimeData(dateAndTime ,id)
}
var reminderFunction = function (id) {
    var idAfterSplit = id.split('-').pop();
    $(id).click(function () {
        $('.remainderButtonStyle').css("pointer-events","none");
        $("#panel").insertAfter(this);
        $("#panel").slideToggle("slow");
        $('.datetimepicker').datetimepicker({});
        $("#cancelButton").click(function () {
            reminderCancelFunction();
        })
        $("#timeSetButton").click(function () {
            reminderSetFunction(idAfterSplit);
            })
    })
}
var getUserTimeData = function(dateAndTime , id){
    var userEnteredDate = moment(dateAndTime , "MM-DD-YYYY HH:mm a A").toDate();
    var presentDate = new Date();
    var differenceTravel = userEnteredDate.getTime()-presentDate.getTime();
    timerFunction(parseInt(differenceTravel) , id)
    }
var timerFunction = function (differenceTravel , id ) {
    var reminderIcon = $("#remainderButton-" + id);
    $('#listItemId-' +id).last().append("<span id='displayTimeId-" +id + "' style='cursor: pointer'></span>")
    var displaytime = $("#displayTimeId-" + id);
    if (differenceTravel <= 0) {
        alert("your reminder time should be greater than present time");
        return;
    }
    var timer = setInterval(function () {
        reminderIcon.css("display", "none");
        displaytime.css("display" , "block");

        var lengthOfTime =moment.duration(differenceTravel ,"milliseconds" );
        differenceTravel = differenceTravel - 1000;
        if(lengthOfTime.minutes() >= 5){
            displaytime.text("time left : " +lengthOfTime.humanize());
        }
        else if(lengthOfTime.minutes() < 5 && lengthOfTime.minutes() < 1){
            displaytime.text("time left : " + lengthOfTime.minutes() + ":" + lengthOfTime.seconds());
        }
        else if(lengthOfTime.minutes() == 0 && lengthOfTime.seconds() > 1) {
            displaytime.text("time left : " +lengthOfTime.seconds());
        }
         if (lengthOfTime.milliseconds() <= 0) {
            clearInterval(timer);
             reminderIcon.css("display", "block");
             displaytime.css("display", "none");
             bootbox.alert({
                title: "Reminder",
                message: "item name : " + $('#item-' + id).text(),
            });
        }
    }, 1000);
}