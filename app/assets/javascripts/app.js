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

$(function () {
    $('.ui.checkbox').checkbox();
    $('.ui.dropdown')
        .dropdown({
            allowAdditions: true,
            transition: 'drop'
        })
    ;

    // $('table').tablesort();

    prepare_dropdowns();
    prepare_seed();
}());
