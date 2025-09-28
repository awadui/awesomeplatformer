extends CanvasLayer

func set_max_health(value: int) -> void:
	$HealthBar.max_value = value

func update_health(value: int) -> void:
	$HealthBar.value = value
	$Label2.text = "%d / %d" % [value, $HealthBar.max_value]  # optional text
