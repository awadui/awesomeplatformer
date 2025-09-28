extends Node

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
			{"name": "Sharpness III", "sprite": preload("res://assets/textures/card-sharpness.png"), "type": type[2], "value": 2},
			{"name": "Rapid Fire", "sprite": preload("res://CardSystem/card design.svg"), "type": type[2], "value": 1},
			{"name": "Spiked Armor", "sprite": preload("res://CardSystem/card design.svg"), "type": type[2], "value": 1},
	],
	"Melee": [
			{"name": "Iron Fists", "sprite": preload("res://assets/textures/card-gauntlets.png"), "type": type[1], "value": 3},
			{"name": "Serious Table Flip", "sprite": preload("res://CardSystem/card design.svg"), "type": type[1], "value": 3}
	],
	"Magic": [
			{"name": "Fireball", "sprite": preload("res://assets/textures/card-fireball.png"), "type": type[0], "value": 2}, # replace png with proper image
			{"name": "Shadow Orb", "sprite": preload("res://CardSystem/card design.svg"), "type": type[0], "value": 5},
	]
}

var current_chosen_upgrades = {} # stores the current upgrade on left and right cards.

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
		
func _on_card_left_chosen():
	emit_signal("upgrade_chosen", upgrades["left"])
	queue_free() # remove interface after choice
	
func _on_card_right_chosen():
	emit_signal("upgrade_chosen", upgrades["right"])
	queue_free()
	
	
	
