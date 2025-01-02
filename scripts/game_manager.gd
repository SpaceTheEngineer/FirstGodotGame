extends Node

var score = 0
var current_level = 0
@onready var score_label: Label = $ScoreLabel
@onready var player: CharacterBody2D = %Player

func add_point():
	score += 1
	score_label.text = "You have collected " + str(score) + " points."

# TODO: Rework this completely (go for an esier/simpler aproach)
func change_level(ammount):
	# Gets the Game node
	var root = get_tree().root.get_child(0)
	
	# Remove current level
	var level = root.get_node("Level_" + current_level)
	root.remove_child(level)
	level.call_deferred("free")
	
	# Load next level
	current_level += ammount
	var next_level_resource = load("res://levels/level_" + current_level +".tscn")
	var next_level = next_level_resource.instance()
	root.add_child(next_level)
