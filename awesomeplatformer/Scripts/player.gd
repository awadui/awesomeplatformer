extends CharacterBody2D

@export var speed = 300
@export var gravity = 30
@export var jump_force = 300

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var cshape = $CollisionShape2D

var is_crouching = false


var standing_cshape = preload("res://Resources/standing_cshape.tres")
var crouching_cshape = preload("res://Resources/crouching_cshape.tres")

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
	
	if Input.is_action_just_pressed("crouch"):
		crouch()
	elif Input.is_action_just_released("crouch"):
		stand_proud()
	
	velocity.x = speed * horizontal_direction
	move_and_slide()
	
	update_animations(horizontal_direction)

func update_animations(horizontal_direction): 
	if is_on_floor():
		if horizontal_direction == 0:
			if is_crouching:
				ap.play("crouch")
			else:
				ap.play("idle")
		else:
			if is_crouching:
				ap.play("crouch")
			else:
				ap.play("run")
	else: 
		if velocity.y < 0:
				ap.play("jump")
		elif velocity.y > 0:
			ap.play("jump")

func switch_direction(horizontal_direction):
	sprite.flip_h = (horizontal_direction == -1)
	sprite.position.x = horizontal_direction * 4

func crouch():
	if is_crouching:
		return
	is_crouching = true
	cshape.shape = crouching_cshape
	

func stand_proud():
	if is_crouching == false:
		return
	is_crouching = false
	cshape.shape = standing_cshape

var max_health = 100;
var health = max_health; # will change later on
var invinc = false;
var invinc_time = 0.5; # half second of invincibility

func flash_red():
	sprite.modulate = Color(1, 0.3, 0.3)  # reddish tint
	await get_tree().create_timer(0.2).timeout
	sprite.modulate = Color(1, 1, 1)  # back to normal

func i_am_invincible():
	invinc = true;
	await get_tree().create_timer(invinc_time).timeout
	invinc = false
