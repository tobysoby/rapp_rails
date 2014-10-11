$(document).ready(function () {
    $('.distance_input').change(function() {
    	var new_velocity = $(this).val() / $('.duration_input').val()
 	 	$('.velocity_input').val(new_velocity);
 	 	var new_pace = $('.duration_input').val() / $(this).val();
 	 	$('.pace_input').val(new_pace);
	});
    $('.duration_input').change(function() {
    	var new_velocity = $('.distance_input').val() / $(this).val()
 	 	$('.velocity_input').val(new_velocity);
 	 	var new_pace = $(this).val() / $('.distance_input').val()
 	 	$('.pace_input').val(new_pace);
	});
});