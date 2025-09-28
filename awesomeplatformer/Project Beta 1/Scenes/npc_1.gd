extends Area2D

@onready var interact_label = $InteractLabel
@onready var message_panel = $MessagePanel
@onready var message_label = $MessagePanel/MessageLabel

@export var instruction_text: String = "DO NOT BE A CONCLUSION MERCHANT"

var player_in_range = false

func _ready():
	interact_label.visible = false
	message_panel.visible = false
	message_label.text = instruction_text

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("Interact"):
		message_panel.visible = !message_panel.visible
		interact_label.visible = !interact_label.visible

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = true
		interact_label.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_range = false
		interact_label.visible = false
		message_panel.visible = false
