extends Control

@onready var start_button = $StartButton

func _ready():
	start_button.connect("pressed", Callable(self, "_on_start_pressed"))

func _on_start_pressed():
	print("Start button pressed!")  # debug message
	get_tree().change_scene_to_file("res://LOCK IN/MainLevel.tscn")
