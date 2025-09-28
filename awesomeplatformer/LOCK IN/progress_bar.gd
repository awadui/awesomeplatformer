extends Control

func set_max_health(value: int):
	$ProgressBar.max_value = value
	
func update_health(value: int): 
	$ProgressBar.value = value
	$HealthText.text = "%d / %d" % [value, $HealthBar.max_value]
