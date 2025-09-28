extends Node2D

func _ready() -> void:
	var player = $Player
	var hud = $HUD   # HUD is the CanvasLayer

	if not hud:
		push_error("HUD node not found! Children: %s" % get_children())
		return

	hud.set_max_health(player.max_health)
	hud.update_health(player.current_health)
	player.health_changed.connect(Callable(hud, "update_health"))
