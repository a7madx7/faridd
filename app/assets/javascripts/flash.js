/**
 * Created by a7madx7 on 8/15/16.
 */
var ready = function () {
    $('.message .close').on('click', function () {
        $(this).closest('.message').transition('fade');
    });
};

$(document).ready(ready);
$(document).on('page:load', ready);