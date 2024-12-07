extends Control

@onready var score = $Score


func _on_texture_button_pressed():
	get_tree().reload_current_scene()

func set_score(value):
	$Score.text = "Your score: " + str(value)
