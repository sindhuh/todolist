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
            else{
                var reminderTime = dateAndTime.replace(/[/ :\s]/g, ",").split(",");
                var month = reminderTime[0];
                var day = reminderTime[1];
                var year = reminderTime[2];
                var hours = reminderTime[3];
                var mins = reminderTime[4];
                var amOrPm = reminderTime[5];
                if(amOrPm == "PM" && hours < 12){
                    hours = parseInt(hours) + 12;
                }
                var userEnteredDate = new Date(parseInt(year),parseInt(month-1),parseInt(day),parseInt(hours),parseInt(mins), 0);
            }
                timerFunction(userEnteredDate, idAfterSplit)
        })
    })
}
var timerFunction = function (inputDate , id ) {
    var displaytime = $("#displayTimeId-" +id);
    var reminderIcon = $("#remainderButton-" +id)
    var presentDate = new Date();
    var differenceTravel = inputDate.getTime() - presentDate.getTime();
    if(differenceTravel == 0){
        return;
    }
    var duration = moment.duration(differenceTravel , 'milliseconds');
    var interval = 1000;
    setInterval(function(){
        reminderIcon.css("display" , "none")
        duration = moment.duration(duration - interval, 'milliseconds');
        if(duration.days() >= 1 ){
            displaytime.text("time left : " +duration.days() +"days");
        }
        else if(duration.hours() >= 1 && duration.days() < 1){
            displaytime.text("time left : " +duration.hours() +"hours");
        }
        else if(duration.hours() < 1 && duration.minutes()> 5){
            displaytime.text("time left : " +duration.minutes() +"minutes");
        }
        else if(duration.minutes() >=1 && duration.minutes() < 5) {
            displaytime.text("time left : " + duration.minutes() + ":" + duration.seconds());
        }
        else if(duration.minutes() == 0 && duration.seconds() >=  0){
            console.log("seconds section");
            displaytime.text("time left : " + duration.seconds() + "secs");
        }
    }, interval);
}