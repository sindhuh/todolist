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
                var userEnteredDate = new Date(parseInt(year),parseInt(month-1),parseInt(day));
                userEnteredDate.setHours(hours);
                userEnteredDate.setMinutes(mins);
            }
            setTimeout(function () {
                timerFunction(userEnteredDate, idAfterSplit)
            }, 1000);
        })
    })
}
var timerFunction = function (inputDate , id ) {
    var displaytime = $("#displayTimeId-" +id);
    var presentDate = new Date();
    var differenceTravel = inputDate.getTime() - presentDate.getTime();
    var YearDifferenceTravel = Math.floor(differenceTravel / 1000 / 60 / 60 / 24 / 365);
    var diffMonths = inputDate.getMonth() - presentDate.getMonth() + (12 * (inputDate.getFullYear() - presentDate.getFullYear()));
    var diffDays = Math.floor((differenceTravel) / (1000 * 60 * 60 * 24));
    var diffhours = Math.floor((differenceTravel) / (1000 * 60 * 60));
    var diffminutes = Math.floor((differenceTravel) / (1000 * 60));
    var diffseconds = Math.floor((differenceTravel) / (1000));
    if(diffDays > 1 ){
        displaytime.css("display" , "block");
        displaytime.text("time left : " +diffDays+ "days");
    }
    else if(diffhours >= 1 && diffDays < 1){
        displaytime.css("display" , "block");
        displaytime.text("time left : " +diffhours+ "hrs");
    }
    else if(diffhours < 1 && diffminutes > 5){
        displaytime.css("display" , "block");
        displaytime.text("time left : " +diffminutes+ "mins");
    }
    else if(diffminutes < 5){
        displaytime.css("display" , "block");
        displaytime.text("time left : " +diffminutes+ ":" +diffseconds);
        if(diffseconds == 0){
            displaytime.css("display" , "none");
        }
    }
    if(YearDifferenceTravel == 0 && diffMonths == 0 && diffDays == 0 && diffhours == 0 && diffminutes == 0 && diffseconds == 0) {
        bootbox.alert ({
            title: "Reminder",
            message: "item name : " +$('#item-'+id).text(),
        });
        return;
    }
    setTimeout(function () {
        timerFunction(inputDate, id)
    }, 1000);
}