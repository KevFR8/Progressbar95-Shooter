extends Control

@onready var score = $Score

func _on_texture_button_pressed() -> void:
	MusicScene._on_music_reload()
	var bgm = load("res://scripts/game/music_scene.gd").new()
	get_tree().root.add_child(bgm)
	get_tree().reload_current_scene()

func set_score(value):
	$Score.text = "Your score: " + str(value)
	
	


