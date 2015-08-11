var reminderFunction = function (id) {
    var idAfterSplit = id.split('-').pop();
    var idOfPanel = '#panel-' + idAfterSplit;
    var hrsId = '#hrsID-' + idAfterSplit;
    var minsId = "#minsID-" + idAfterSplit;
    $(id).click(function () {
        $(idOfPanel).slideToggle("slow");
        $('#cancelButton-' + idAfterSplit).click(function () {
            $(hrsId).val("");
            $(minsId).val("");
            $(idOfPanel).slideUp("slow");
        })
        $("#timeSetButton-" + idAfterSplit).click(function () {
            var hours = parseInt($(hrsId).val());
            var minutes = parseInt($(minsId).val());
            $(idOfPanel).slideUp("slow");
            if (isNaN(hours) || isNaN(minutes)) {
                alert("Please enter  valid integers");
                return;
            }
            setTimeout(function () {
                timerFunction(hours, minutes, idAfterSplit)
            }, 1000);
        })
    })
}
var timerFunction = function (hours, minutes, id) {
    console.log(id);
   var name =  $('#item-'+id).text();
    console.log("name: " +name)
    var date = new Date();
    var presentHour = date.getHours();
    var presentMinute = date.getMinutes();
    if (presentHour == hours && presentMinute == minutes) {
        bootbox.alert ({
            title: "Reminder",
            message: "item name : " +$('#item-'+id).text(),
        });
        return;
    }
    setTimeout(function () {
        timerFunction(hours, minutes, id)
    }, 1000);
}