extends CanvasLayer

signal upgrade_chosen(upgrade_type)

@onready var cardleft = $CardLeft
@onready var cardright = $CardRight
@onready var anim = $intro 

var upgrades = { # all values of current upgrades
	"Left": {"type": type, "value": 1},
	"Right": {"type": type, "value": 1}
}
var type = ["mana", "melee", "weapon"] # called when card has different type

var upgrade_pool = { # ADD ALL NEW CARDS + BUFFS HERE!!
	"Weapon": [
			{"name": "Sharpness III", "sprite": preload("res://assets/textures/card-sharpness.png"), "type": {"attack": 5}},
			{"name": "Rapid Fire", "sprite": preload("res://CardSystem/card design.svg"), "type": {"attack": 5}},
			{"name": "Spiked Armor", "sprite": preload("res://CardSystem/card design.svg"), "type": type[2], "value": 1},
	],
	"Melee": [
			{"name": "Iron Fists", "sprite": preload("res://assets/textures/card-gauntlets.png"), "type": {"attack": 5}},
			{"name": "Serious Table Flip", "sprite": preload("res://CardSystem/card design.svg"), "type": type[1], "value": 3}
	],
	"Magic": [
			{"name": "Fireball", "sprite": preload("res://assets/textures/card-fireball.png"), "type": type[0], "value": 2}, # replace png with proper image
			{"name": "Shadow Orb", "sprite": preload("res://CardSystem/card design.svg"), "type": type[0], "value": 5},
	]
}

var current_chosen_upgrades = {} # stores the current upgrade on left and right cards.
var left_choice
var right_choice
var player_ref

func on_ready(): # Stalls card logic until anim finishes
	cardleft.disabled = true;
	cardright.disabled = true;
	
	anim.play("intro")
	anim.connect("animation_finished", Callable(self, "_on_anim_finished"));
	
	cardleft.connect("pressed", Callable(self, "_on_card_left_chosen"));
	cardright.connect("pressed", Callable(self, "_on_card_right_chosen"));

func _on_intro_finished(anim_name):
	if anim_name == "intro":
		cardleft.disabled = false
		cardright.disabled = false

func show_cards(player):
	player_ref = player
	# Pick two random categories
	var categories = upgrades.keys()
	left_choice = upgrades[categories[randi() % categories.size()]].pick_random()
	right_choice = upgrades[categories[randi() % categories.size()]].pick_random()

	# Set textures
	card_left.texture = left_choice["texture"]
	card_right.texture = right_choice["texture"]

	# Play animation
	visible = true
	anim.play("cards_slide_in")

func _on_CardLeft_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		apply_upgrade(left_choice)
		hide_cards()

func _on_CardRight_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		apply_upgrade(right_choice)
		hide_cards()

func apply_upgrade(upgrade):
	for key in upgrade["effect"].keys():
		player_ref.apply_upgrade(key, upgrade["effect"][key])

func hide_cards():
	visible = false
	
func _on_card_left_chosen():
	emit_signal("upgrade_chosen", upgrades["left"])
	queue_free() # remove interface after choice
	
func _on_card_right_chosen():
	emit_signal("upgrade_chosen", upgrades["right"])
	queue_free()
	
	
	
