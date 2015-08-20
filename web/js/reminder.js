var timer;
var reminderCancelFunction = function(){
   // console.log(" reminderCancelFunction ");
    $('.remainderButton').css("pointer-events","auto");
    $('#dateId').val("");
    $("#setTimerPanel").slideUp("slow");
}
var i = 0 ;
var reminderSetFunction = function(id) {
  //  console.log(" reminderSetFunction ");
    $('.remainderButton').css("pointer-events","auto");
    var dateAndTime = $("#dateId").val();
    $("#setTimerPanel").slideUp("slow");
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
    i++;
    getUserTimeData(dateAndTime ,id);
}
var setUpReminderButton = function (id) {
    //console.log(" setUpReminderButton ");
    var idAfterSplit = id.split('-').pop();
    $(id).click(function () {
        $('.remainderButton').css("pointer-events","none");
        var setTimerPanel =  $("#setTimerPanel");
        setTimerPanel.insertAfter(this);
        setTimerPanel.slideToggle("slow");
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
    //clearInterval(timer);
    timer = setInterval(function () {
        reminderIcon.css("display", "none");
        displaytime.css("display" , "block");
        var lengthOfTime =moment.duration(differenceTravel ,"milliseconds" );
        differenceTravel = differenceTravel - 1000;
        if(lengthOfTime.minutes() >= 5){
            displaytime.text(lengthOfTime.humanize() +" left");
        }
        else if(lengthOfTime.minutes() < 5 && lengthOfTime.minutes() < 1){
            displaytime.text(lengthOfTime.minutes() + ":" + lengthOfTime.seconds() + " left");
        }
        else if(lengthOfTime.minutes() == 0 && lengthOfTime.seconds() > 1) {
            displaytime.text(lengthOfTime.seconds() + " left");
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
};
