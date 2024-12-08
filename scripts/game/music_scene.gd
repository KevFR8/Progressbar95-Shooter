extends Node

@export var music_path: String = "res://asset/bgm/pb_theme_midi.mp3" # Chemin du fichier audio
var music_player: AudioStreamPlayer

func _ready():
	if not music_player:
		music_player = AudioStreamPlayer.new()
		add_child(music_player)
	music_player.stream = load(music_path)

func play_music():
	if not music_player.playing:
		music_player.play()

func stop_music():
	if music_player.playing:
		music_player.stop()

func reset_music():
	stop_music()
	play_music()
