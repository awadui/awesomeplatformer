extends CharacterBody2D

@export var speed = 300
@export var gravity = 30
@export var jump_force = 300

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var gm = get_node("/root/Main/GameManager")

func _ready():
	gm.connect("hitpoints_changed", Callable(self, "on_hitpoints_changed"));
	
func on_hitpoints_changed(current, max):
	print([current, max])
	# Change to UI health bar!!!

func take_damage(amount: int):
	var reduced = max(amount - gm.player_stats["defense"], 0)
	gm.player_stats["current_hp"] -= reduced
	gm.player_stats["current_hp"] = max(gm.player_stats["current_hp"], 0)
	gm.emit_signal("hitpoints_changed", gm.player_stats["current_hp"], gm.player_stats["max_hp"])

func _physics_process(_delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
	
	if Input.is_action_just_pressed("jump"): #&& is_on_floor():
		velocity.y = -jump_force
	
	var horizontal_direction = Input.get_axis("move_left", "move_right ")
	
	if horizontal_direction != 0:
		switch_direction(horizontal_direction)
	
	velocity.x = speed * horizontal_direction
	move_and_slide()
	
	update_animations(horizontal_direction)

func update_animations(horizontal_direction): 
	if is_on_floor():
		if horizontal_direction == 0:
			ap.play("idle")
		else:
			ap.play("run")
	else: 
		if velocity.y < 0:
				ap.play("jump")
		elif velocity.y > 0:
			ap.play("jump")

func switch_direction(horizontal_direction):
	sprite.flip_h = (horizontal_direction == -1)
