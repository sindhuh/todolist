var deleteFunction = function (id , islistEmpty) {
    var ID = id.split('-').pop();
    $('#checkboxId-' + ID).click(function () {
        $('#listItemId-' + ID).animate({"margin-left": "30%", "alpha": 0}, {
            duration: 500,
            start: function () {
            }, complete: function () {
                $(this).remove();
            }
        });
        $.ajax({
            url: 'deleteItem.jsp',
            data: {
                id: ID,
            },
            method: 'POST'
        }).done(function () {
            if (($('#listBody').children().length) == 0) {
                islistEmpty = true;
                $('#emptyListMessage').css("display", "block");
            }
        }).fail(function () {
        });
    })
}