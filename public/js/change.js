$(document).ready(function () {
    $('#date').editable();
    $('#time').editable();
    $('#distance').editable();
    $('#length').editable();
    
    $('#delete_run').click(function () {
        var specific_date = $('#date').text();
        $.get('/delete/' + specific_date);
    });
    
});