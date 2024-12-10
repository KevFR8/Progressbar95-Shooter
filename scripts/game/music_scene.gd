class_name BGM extends Node

@onready var bgm = $BGM

func _on_music_stop():
	$BGM.stop()
	
func _on_music_reload():
	$BGM.play()
