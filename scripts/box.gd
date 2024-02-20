extends Node2D


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.queue_free()
	elif body.name == "Remove":
		queue_free()
