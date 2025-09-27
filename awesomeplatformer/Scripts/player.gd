extends CharacterBody2D

func _physics_process(delta):
	var horizontal_direction = Input.get_axis("move_left", "move_right ")
	
	velocity.x = 300 * horizontal_direction
	move_and_slide()
