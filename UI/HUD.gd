extends Control

onready var label = $MarginContainer/VBoxContainer/HBoxContainer/ScoreLabel

var score = 0

func _ready() -> void:
	label.text = str(score)
	
func _enter_tree() -> void:
	Events.connect("score_changed", self, "_on_score_changed")

func _exit_tree() -> void:
	Events.disconnect("score_changed", self, "_on_score_changed")

func _on_score_changed (value):
	score += value
	label.text = str(score)
