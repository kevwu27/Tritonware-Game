extends Node2D

var score = 0

@onready var scoreLabel = get_node("CanvasLayer/RichTextLabel")

func _on_whale_collected():
	score = score + 1
	scoreLabel.clear()
	var scoreText = "Whales: " + str(score)
	scoreLabel.add_text(scoreText)
