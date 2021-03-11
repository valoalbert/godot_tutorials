extends Area2D

export(String, FILE, "*.tscn") var next_scene_path

func _on_Portal_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene(next_scene_path)
	pass # Replace with function body.
