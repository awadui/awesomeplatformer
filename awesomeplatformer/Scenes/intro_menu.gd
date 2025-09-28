extends Control

@onready var start_button = $StartButton

func _ready():
	start_button.connect("pressed", Callable(self, "_on_start_pressed"))
	
func on_start_pressed():
	var main_scene = preload("res://Scenes/world.tscn").instantiate()
	get_tree().root.add_child(main_scene)
	queue_free()
