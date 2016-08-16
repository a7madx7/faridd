/**
 * Created by a7madx7 on 8/15/16.
 */
$(function () {
    $('.message .close').on('click', function () {
        $(this).closest('.message').transition('fade');
    });
});