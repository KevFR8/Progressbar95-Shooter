extends Node2D

# Export variables
@export var enemy_scenes: Array[PackedScene] = []  # Tableau des ennemis normaux
@export var special_enemy_scenes: Array[PackedScene] = []  # Tableau des ennemis spéciaux
@export var points = 50

var audio = preload("res://scripts/game/music_scene.gd")

# Onready variables
@onready var player_spawn_pos = $Player
@onready var bullet_container = $BulletContainer
@onready var timer = $EnemySpawnTimer
@onready var enemy_container = $EnemyContainer
@onready var hud = $UI/HUD
@onready var gos = $UI/GameOverScreen

var is_music_playing = true
var player = null
var score := 0:
	set(value):
		score = value
		hud.score = score
		_adjust_enemy_spawn_rate()  # Ajuster le taux d'apparition des ennemis basé sur le score

func _ready():
	score = 0
	player = get_tree().get_first_node_in_group("player")
	assert(player != null)
	player.global_position = player_spawn_pos.global_position
	player.bullet_shot.connect(_on_player_bullet_shot)
	player.killed.connect(_on_player_killed)

	# Commencer avec un taux de spawn rapide
	timer.wait_time = 1.0
	timer.start()

func _adjust_enemy_spawn_rate():
	# Ajuster le temps d'apparition basé sur le score
	var initial_wait_time = 1.0  # Temps d'attente initial court
	var min_wait_time = 1.5  # Temps minimum d'attente
	var max_wait_time = 3.0  # Temps maximum d'attente
	var score_factor = clamp(score / 1000.0, 0.0, 1.0)  # Ajustement basé sur le score

	# Si le score est inférieur à 500, utiliser le temps d'attente initial
	if score < 500:
		timer.wait_time = initial_wait_time
	else:
		# Ajustement normal basé sur le score
		timer.wait_time = lerp(max_wait_time, min_wait_time, score_factor)

func _on_player_bullet_shot(bullet_scene, location):
	var bullet = bullet_scene.instantiate()
	bullet.global_position = location
	bullet_container.add_child(bullet)

func _on_enemy_spawn_timer_timeout():
	if score >= 500:
		# Clippy Spawner Normal
		var special_enemy = special_enemy_scenes.pick_random().instantiate()
		special_enemy.global_position = Vector2(randf_range(5, 510), 0)
		enemy_container.add_child(special_enemy)
		special_enemy.killed.connect(_on_enemy_killed)

		# Dangerous Clippy Spawner
		var random_enemy = enemy_scenes.pick_random().instantiate()
		random_enemy.global_position = Vector2(randf_range(5, 510), 0)
		enemy_container.add_child(random_enemy)
		random_enemy.killed.connect(_on_enemy_killed)
	else:
		var enemy = enemy_scenes.pick_random().instantiate()
		enemy.global_position = Vector2(randf_range(5, 510), 0)
		enemy_container.add_child(enemy)
		enemy.killed.connect(_on_enemy_killed)

func _on_enemy_killed(points):
	score += points

func _on_player_killed():
	gos.set_score(score)
	$BSOD.play()
	$Ambient.queue_free()
	await get_tree().create_timer(2.5).timeout
	$Shutdownfan.play()
	gos.visible = true
	MusicScene._on_music_stop()  # Arrêter la musique

func _on_pause_button_pressed():
	$ClickSFX.play()
	$PauseMenu.show()
	get_tree().paused = true

func _on_help_button_pressed():
	$ClickSFX.play()
	$Help_Menu.show()
	get_tree().paused = true
