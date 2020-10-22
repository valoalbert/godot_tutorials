extends Area2D

export (String) var escena

func _on_Portal_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://Scenes/"+escena+".tscn")
	pass # Replace with function body.
