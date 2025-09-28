extends Node

signal card_played(card: Card)

var current_hand: Array[Card] = []
var sacrifices: Array[Card] = []
var player_stats := {"attack": 0, "defense": 0, "speed": 0}

func add_to_hand(card: Card) -> void:
	current_hand.append(card)

func sacrifice_card(card: Card) -> void:
	if card in current_hand:
		current_hand.erase(card)
		sacrifices.append(card)
		print("Sacrificed %s" % card.name)

func play_card(card: Card) -> void:
	if card.cost <= sacrifices.size():
		# pay the cost
		for i in range(card.cost):
			sacrifices.pop_front()
		# apply buffs
		for key in card.buffs.keys():
			player_stats[key] += card.buffs[key]
		current_hand.erase(card)
		emit_signal("card_played", card)
		print("%s played! Buffs applied: %s" % [card.name, card.buffs])
	else:
		print("Not enough sacrifices to play %s" % card.name)
