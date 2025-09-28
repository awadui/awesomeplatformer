extends Node2D

func _ready():
	$Player.connect("health_changed", Callable($HUD, "update_health"))
	$HUD.set_max_health($Player.max_health)
	$HUD.update_health($Player.current_health)
