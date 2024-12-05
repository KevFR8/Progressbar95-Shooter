class_name Player extends CharacterBody2D

@export var speed = 100

@onready var muzzle = $Muzzle
@onready var shot_sfx = $ShotSFX

signal bullet_shot(bullet_scene, location)

var bullet_scene = preload("res://scene/bullet/bullet.tscn")


func _process(delta):
	if Input.is_action_just_pressed("shot"):
		shoot() 
		shot_sfx.play()

func _physics_process(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction *   speed
	move_and_slide()
	

	
func shoot():
	bullet_shot.emit(bullet_scene, muzzle.global_position)
	
func _die():
	queue_free()
	
	
