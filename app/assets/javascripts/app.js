var prepare_dropdowns = function () {
    $('#country_selection').dropdown('set selected', 'eg').dropdown('set text', 'Egypt');
    $('#country_selection .text').prepend('<i class="eg flag"> </i>');
    $('#gender_selection').dropdown('set selected', 'Male').dropdown('set text', 'Male');
    $('#gender_selection .text').prepend('<i class="male icon"> </i>');
    $('#profession_selection').dropdown('set selected', 'pharmacist').dropdown('set text', 'Pharmacist');
    $('#profession_selection .text').prepend('<i class="doctor icon"> </i>');
};

var prepare_seed = function () {
    $('#user_email').val('ahmad.hamdi.emara@gmail.com');
    $('#user_username').val('a7madx7');
    $('#user_first_name').val('Ahmad')
    $('#user_last_name').val('Hamdi')
    $('#user_password').val('#1forever')
    $('#user_password_confirmation').val('#1forever')
};

var ready = function () {
    $('.ui.checkbox').checkbox();
    // todo: replace the class selector with the id selector for a more specific approach
    $('.ui.dropdown')
        .dropdown({
            allowAdditions: true,
            transition: 'drop'
        })
    ;

    $('#search_box')
        .search({
            apiSettings: { url: '/search?term={query}' },
            minCharacters : 3,
            type: 'category'
        })
    ;

    $('table').tablesort();

    var maxHeight = - 1;
    cards = $('.drugs.index .ui.card');
    cards.each(function () {
        maxHeight = maxHeight > $(this).height() ? maxHeight : $(this).height();
    });
    cards.each(function () {
        $(this).height(maxHeight);
    });
    // prepare_dropdowns();
    // prepare_seed();
};

$(document).ready(ready);
$(document).on('page:change', ready);