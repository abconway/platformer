extends Area2D

signal collected


func _on_body_entered(body):
	if body.name == "Player":
		queue_free()
		collected.emit()
	elif body.name == "Remove":
		queue_free()
