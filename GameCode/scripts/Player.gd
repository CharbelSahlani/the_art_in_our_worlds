extends KinematicBody2D


var velocity = Vector2.ZERO
var move_speed = 100

onready var player_anim = $AnimatedSprite
onready var fire_anim = $Fire
# Called when the node enters the scene tree for the first time.

func _ready():
	if GLOBALS.color == 0:
		player_anim.play("Blue")
	elif GLOBALS.color == 1:
		player_anim.play("Red")

func _physics_process(delta):
	move()


func move():
	if Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		fire_anim.play("BlueStart")
	if Input.is_action_pressed("move_left"):
		velocity.x = -move_speed
	elif Input.is_action_pressed("move_right"):
		velocity.x = move_speed
	else:
		velocity.x = 0
		fire_anim.play("BlueEnd")
	velocity = move_and_slide(velocity)


func _on_Fire_animation_finished():
	if fire_anim.animation == "BlueStart":
		fire_anim.play("BlueLoop")
