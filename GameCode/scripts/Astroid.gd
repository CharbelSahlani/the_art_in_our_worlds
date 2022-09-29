extends Area2D


var move_sped = 80

func _ready():
	randomize()
	rotation_degrees = randi() % 360
	move_sped = randi() % 100 + 80
	scale.x = rand_range(0.15,0.4)
	scale.y = scale.x
	
func _physics_process(delta):
	position.y += delta * move_sped


func _on_Astroid_body_entered(body):
	if body.name == "Player":
		body.queue_free()
		GLOBALS.emit_signal("player_death")


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
