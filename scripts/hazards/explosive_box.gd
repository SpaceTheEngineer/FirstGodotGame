extends Node2D

@onready var timer: Timer = $AnimatedSprite2D/Timer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var triggered = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !triggered:
		triggered = true
		timer.start()
		animated_sprite.play("explosion")
	
	
func _on_timer_timeout() -> void:
	animated_sprite.play("exploded")
	animation_player.play("explosion")
	pass
	
