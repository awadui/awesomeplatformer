extends Node

signal hitpoints_changed(current, max)

var player_stats = {
	"max_hp": 10,
	"current_hp": 10,
	"attack_power": 1,
	"attack_speed": 1,
	"melee_damage": 1,
	"magic_power": 1,
	"mana": 0,
	"defense": 0,
	"blindness": 0
}

func apply_upgrade(upgrade: Dictionary):
	match upgrade["type"]:
		"attack":
			player_stats["attack_power"] += upgrade["value"]
		"attack_speed":
			player_stats["attack_speed"] += upgrade["value"]
		"melee_damage":
			player_stats["melee_damage"] += upgrade["value"]
		"magic_damage":
			player_stats["magic_power"] += upgrade["value"]
		"mana":
			player_stats["mana"] += upgrade["value"]
		"defense":
			player_stats["defense"] += upgrade["value"]
		"hp":
			player_stats["max_hp"] += upgrade["value"]
			player_stats["current_hp"] += upgrade["value"]  # heal up when gaining HP
			emit_signal("hitpoints_changed", player_stats["current_hp"], player_stats["max_hp"])
