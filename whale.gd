extends Area2D

var score = 0

func _on_body_entered(body):
	if(body.name == "Player"):
		queue_free()
		score += 1

