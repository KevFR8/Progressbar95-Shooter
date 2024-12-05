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

func _input(event):
	if Input.is_action_just_pressed("pause"):
		pause_unpaused()
	
func _on_texture_button_pressed():
	$ClickSFX.play()
	get_tree().paused = false
	hide()

func _on_continue_button_pressed():
	$ClickSFX.play()
	get_tree().paused = false
	hide()

func _on_exit_button_pressed():
	get_tree().quit()


func _on_steam_button_pressed():
	OS.shell_open("https://store.steampowered.com/app/1304550/Progressbar95/")
