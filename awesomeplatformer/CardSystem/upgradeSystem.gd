extends CanvasLayer

signal upgrade_chosen(upgrade_data)

@onready var card_left = $CardLeft
@onready var card_right = $CardRight
@onready var anim = $AnimationPlayer

# Define upgrade pool
var upgrade_pool = {
	"Weapon": [
		{"name": "Sharpness III", "sprite": preload("res://assets/textures/card-sharpness.png"), "effect": {"attack": 5}},
	],
	"Melee": [
		{"name": "Iron Fists", "sprite": preload("res://assets/textures/card-gauntlets.png"), "effect": {"attack": 5}},
	],
	"Magic": [
		{"name": "Fireball", "sprite": preload("res://assets/textures/card-fireball.png"), "effect": {"magic": 2}},
	]
}

var left_choice
var right_choice
var player_ref

func _ready():
	visible = false
	card_left.disabled = true
	card_right.disabled = true

	anim.connect("animation_finished", Callable(self, "_on_anim_finished"))
	card_left.connect("pressed", Callable(self, "_on_card_left_chosen"))
	card_right.connect("pressed", Callable(self, "_on_card_right_chosen"))

func show_cards(player):
	player_ref = player

	var categories = upgrade_pool.keys()
	left_choice = upgrade_pool[categories[randi() % categories.size()]].pick_random()
	right_choice = upgrade_pool[categories[randi() % categories.size()]].pick_random()

	# Apply textures
	card_left.texture_normal = left_choice["sprite"]
	card_right.texture_normal = right_choice["sprite"]

	visible = true
	anim.play("intro")

func _on_anim_finished(anim_name):
	if anim_name == "intro":
		card_left.disabled = false
		card_right.disabled = false

func _on_card_left_chosen():
	apply_upgrade(left_choice)
	emit_signal("upgrade_chosen", left_choice)
	hide_cards()

func _on_card_right_chosen():
	apply_upgrade(right_choice)
	emit_signal("upgrade_chosen", right_choice)
	hide_cards()

func apply_upgrade(upgrade):
	for key in upgrade["effect"].keys():
		player_ref.apply_upgrade(key, upgrade["effect"][key])

func hide_cards():
	visible = false
