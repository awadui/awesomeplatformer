extends CharacterBody2D

@export var speed = 300
@export var gravity = 30
@export var jump_force = 300

@onready var ap = $AnimationPlayer
@onready var sprite = $Sprite2D

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
	sprite.position.x = horizontal_direction * 4
