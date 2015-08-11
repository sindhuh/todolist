var updateItemFunction = function (id) {
    var editedTextNode = id;
    $(editedTextNode).focus(function () {
        $(editedTextNode).keypress(function (event) {
            if (event.which == 13) {
                event.preventDefault();
                $(editedTextNode).blur();
                var updatedItem = $(editedTextNode).text();
                var databaseId = editedTextNode.split('-').pop();
                $.ajax({
                    url: 'updateItem.jsp',
                    data: {
                        id: databaseId,
                        itemName: updatedItem
                    },
                    method: 'POST'
                }).done(function () {
                }).fail(function () {
                });
            }
        });
    })
}