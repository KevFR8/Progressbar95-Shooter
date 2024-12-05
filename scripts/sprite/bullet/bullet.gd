class_name Bullet extends Area2D

@export var speed = 100

func _physics_process(delta):
	global_position.y += -speed * delta
	
func _on_visibility_screen_exited():
	queue_free()

func _on_area_entered(area):
	if area is Enemy:
		queue_free()
		
