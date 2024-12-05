extends CanvasLayer

var pause = false

func pause_unpaused():
	pause = !pause
	
	if pause:
		get_tree().paused = true
		show()
	else:
		get_tree().paused = false
		hide()

func _on_close_pressed():
	$ClickSFX.play()
	get_tree().paused = false
	hide()
