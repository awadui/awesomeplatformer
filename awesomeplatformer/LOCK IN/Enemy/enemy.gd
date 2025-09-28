extends CharacterBody2D

@export var speed: float = 100.0       
@export var patrol_distance: float = 200.0 
@export var pause_time: float = 2.0      
@export var max_health: int = 100
@export var attack_power: int = 10  

var current_health: int
var health: int
var direction: int = 1
var start_position: Vector2
var moving: bool = true

@onready var pause_timer: Timer = $Timer
@onready var sprite = $Sprite2D

func _ready():
	start_position = global_position
	pause_timer.wait_time = pause_time
	pause_timer.connect("timeout", Callable(self, "_on_pause_timeout"))

func take_damage(amount: int):
	current_health -= amount;
	if current_health <= 0:
		die()
	
func die():
	queue_free()


func _physics_process(_delta: float) -> void:
	if moving:
		velocity.x = direction * speed
		move_and_slide()
		
		$Sprite2D.flip_h = direction < 0
		
		var distance = abs(global_position.x - start_position.x)
		if distance >= patrol_distance:
			_pause_and_turn()
			
	else:
		velocity.x = 0
		move_and_slide()

func _pause_and_turn():
	moving = false
	pause_timer.start()

func _on_pause_timeout():
	direction *= -1 
	moving = true

	if health <= 0:
		queue_free()
