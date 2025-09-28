extends Node2D

func _ready():
	var card_manager = $CardManager
	var player = $Player

	card_manager.connect("card_played", Callable(player, "apply_buffs"))

	# Example: create a test card
	var frenzy = Card.new()
	frenzy.name = "Frenzy"
	frenzy.cost = 1
	frenzy.buffs = {"attack": +2, "defense": -1}

	card_manager.add_to_hand(frenzy)
