var mouseEventFunction = function (Id) {
    var checkboxId = Id.split('-').pop();
    var checkboxNode = $('#checkboxId-' + checkboxId);
    $(Id).on({
        mouseenter: function () {
            checkboxNode.css('visibility', 'visible');
        },
        mouseleave: function () {
            checkboxNode.css('visibility', 'hidden');
        }
    })
}