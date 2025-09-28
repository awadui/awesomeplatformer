extends Resource

class_name Card

@export var name: String
@export var cost: int = 0 # sacrifices required
@export var buffs: Dictionary = {} # e.g. {"attack": +2, "speed": -1}
