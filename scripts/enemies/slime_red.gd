extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -200.0
const JUMP_INTERVAL = 3

var direction = 1
var can_jump = true

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	
	# Handle jump.
	if can_jump and is_on_floor():
		velocity.y = JUMP_VELOCITY	
		can_jump = false
		timer.wait_time = JUMP_INTERVAL
		timer.start()
	
	if not is_on_floor():
		velocity.x = direction * SPEED
	else:
		velocity.x = 0
	
	move_and_slide()

func _on_timer_timeout() -> void:
	can_jump = true
