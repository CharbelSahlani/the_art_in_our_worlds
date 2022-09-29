extends Area2D

onready var star_anim = $AnimatedSprite
onready var star_effect = $AnimationPlayer
var move_speed = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	star_effect.play("effect")
	rotation_degrees = randi() % 360

func _process(delta):
	position.y += delta * move_speed



func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()


func _on_Star_body_entered(body):
	if body.name == "Player":
		$CollisionShape2D.set_deferred("disabled", true)
		GLOBALS.emit_signal("take_star")
		star_effect.play("RESET")
		star_anim.play("Taken")


func _on_AnimatedSprite_animation_finished():
	if star_anim.animation == "Taken":
		queue_free()
