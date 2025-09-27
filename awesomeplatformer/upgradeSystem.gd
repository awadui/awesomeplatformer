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
	
	
