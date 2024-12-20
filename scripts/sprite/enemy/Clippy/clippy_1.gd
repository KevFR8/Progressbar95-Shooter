class_name Enemy_Red extends Node2D

signal killed(points)

@export var speed = 10
@export var health = 5
@export var points = 50

var width = 0
var direction = 1

func _physics_process(delta):
	global_position.y -= -speed * delta
 
func _on_visibility_screen_exited():
	queue_free()
	
func _on_area_2d_area_entered(body):
	health -= 1
	$TouchedEnemySFX.play()
	if health == 0:
		killed.emit(points)
		queue_free()


