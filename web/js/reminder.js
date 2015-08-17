var reminderFunction = function (id) {
    var idAfterSplit = id.split('-').pop();
    var idOfPanel = '#panel-' + idAfterSplit;
    $(id).click(function () {
        $(idOfPanel).slideToggle("slow");
        $('#cancelButton-' + idAfterSplit).click(function () {
            $('#dateId-'+idAfterSplit).val("");
            $(idOfPanel).slideUp("slow");
        })
        $("#timeSetButton-" + idAfterSplit).click(function () {
            var dateAndTime =$('#dateId-'+idAfterSplit).val();
            $(idOfPanel).slideUp("slow");
            if (!dateAndTime.trim()) {
                return;
            }
            else {
                $.ajax({
                    url : "timer.jsp",
                    data : {
                        timeDuration : dateAndTime,
                        id : idAfterSplit,
                    },
                    method : "POST"
                }).done(function () {
                }).fail(function () {
                });
                getUserTimeData(dateAndTime , idAfterSplit)
            }
        })
    })
}
var getUserTimeData = function(dateAndTime , id){
    var userEnteredDate = moment(dateAndTime , "MM-DD-YYYY HH:mm a A").toDate();
    console.log("userentereddate : " +userEnteredDate);
    var presentDate = new Date();
    var differenceTravel = userEnteredDate.getTime()-presentDate.getTime();
    timerFunction(parseInt(differenceTravel) , id)
    }
var timerFunction = function (differenceTravel , id ) {
    var displaytime = $("#displayTimeId-" + id);
    displaytime.css("display" , "block");
    console.log("displayTimeId : #displayTimeId-" +id);
    var reminderIcon = $("#remainderButton-" + id);
    console.log("remainderButton : #remainderButton-" +id);
    if (differenceTravel <= 0) {
        return;
    }
    var timer = setInterval(function () {
        reminderIcon.css("display", "none");
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
    displaytime.click(function () {
        $("#panel-" + id).slideDown();
        $('#cancelButton-' + id).click(function () {
            $('#dateId-' + id).val("");
            clearInterval(timer);
            displaytime.text("");
            reminderIcon.css("display", "block")
        })
        $("#timeSetButton-" + id).click(function () {
            var dateAndTime = $('#dateId-' + id).val();
            $("#panel-" + id).slideUp("slow");
            clearInterval(timer);
            if (!dateAndTime.trim()) {
                return;
            }
            else {
                getUserTimeData(dateAndTime, id);
            }
        })
    });
}