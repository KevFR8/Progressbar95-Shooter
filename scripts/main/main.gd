extends Node2D

# Export variable
@export var enemy_scenes: Array[PackedScene] = []
@export var points = 50

var audio = preload("res://scripts/game/music_scene.gd")

# Onready variable
@onready var player_spawn_pos = $Player
@onready var bullet_container = $BulletContainer
@onready var timer = $EnemySpawnTimer
@onready var enemy_container = $EnemyContainer
@onready var hud = $UI/HUD
@onready var gos = $UI/GameOverScreen

var player = null
var score := 0:
	set(value):
		score = value
		hud.score = score

func _ready():
	score = 0
	player = get_tree().get_first_node_in_group("player")
	assert(player!=null)
	player.global_position = player_spawn_pos.global_position
	player.bullet_shot.connect(_on_player_bullet_shot)
	player.killed.connect(_on_player_killed)
	
func _on_player_bullet_shot(bullet_scene, location):
	var bullet = bullet_scene.instantiate()
	bullet.global_position = location
	bullet_container.add_child(bullet)
	
func _on_enemy_spawn_timer_timeout():
	var e = enemy_scenes.pick_random().instantiate()
	var spawn_x = randf_range(5, 515) 
	var spawn_y = 0 
	
	e.global_position = Vector2(spawn_x, spawn_y)
	enemy_container.add_child(e)
	e.killed.connect(_on_enemy_killed)

func _on_enemy_killed(points):
	score += points
	
func _on_player_killed():
	$BSOD.play()
	await get_tree().create_timer(1.5).timeout
	gos.visible = true
	
func _on_pause_button_pressed():
	$ClickSFX.play()
	$PauseMenu.show()
	get_tree().paused = true

func _on_help_button_pressed():
	$ClickSFX.play()
	$Help_Menu.show()
	get_tree().paused = true
	
		
