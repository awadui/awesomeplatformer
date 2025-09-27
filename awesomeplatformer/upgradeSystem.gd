extends Node

signal upgrade_chosen(upgrade_type)

@onready var cardleft = $CardLeft
@onready var cardright = $CardRight
@onready var anim = $intro 

var upgrades = { # houses value of current upgrades
	"Left": {"type": type, "value": 1},
	"Right": {"type": type, "value": 1}
}
var type = ["mana", "strength", "weapon"] # called when card has different type

var upgrade_pool = {
	"Weapon": [
			{"name": "Sharpness", "sprite": preload("res://CardSystem/card design.svg"), "type": "attack", "value": 2},
			{"name": "Rapid Fire", "sprite": preload("res://CardSystem/card design.svg"), "type": "attack_speed", "value": 1},
	],
	"Melee": [
			{"name": "Iron Fists", "sprite": preload("res://CardSystem/card design.svg"), "type": "melee_damage", "value": 3},
			{"name": "Spiked Armor", "sprite": preload("res://CardSystem/card design.svg"), "type": "thorns", "value": 1},
	],
	"Magic": [
			{"name": "Fireball", "sprite": preload("res://CardSystem/card design.svg"), "type": "magic_damage", "value": 2}, # replace png with proper image
			{"name": "Mana Surge", "sprite": preload("res://CardSystem/card design.svg"), "type": "mana", "value": 5},
	]
}

func on_ready():
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
	
	
	
