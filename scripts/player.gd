extends CharacterBody2D

@onready var death_timer: Timer = $DeathTimer

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var max_jumps = 1
var jumps = 0

var max_health = 1
var health = 1

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Enable jumping
	if is_on_floor():
		jumps = max_jumps
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and jumps > 0:
		velocity.y = JUMP_VELOCITY
		jumps -= 1

	# Gets input direction: -1 / 0 / 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animation
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jumping")
	
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func add_power(power_name):
	match power_name:
		"double_jump":
			max_jumps += 1


func take_damage(damage):
	health -= damage
	if health <= 0:
		print("You died!")
		Engine.time_scale = 0.5
		get_node("CollisionShape2D").queue_free()
		death_timer.start()


func _on_death_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
