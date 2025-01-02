extends Node

var score = 0
var current_level = 0
@onready var score_label: Label = $ScoreLabel
@onready var player: CharacterBody2D = %Player

func add_point():
	score += 1
	score_label.text = "You have collected " + str(score) + " points."

# TODO: Rework this completely (go for an esier/simpler aproach)
func change_level():
	pass
