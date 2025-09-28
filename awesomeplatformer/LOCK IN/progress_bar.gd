extends Control
func set_max_health(value):
	$ProgressBar.max_value = value
	
func update_health(value):
	$ProgressBar.value = value
