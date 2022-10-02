extends CanvasLayer


onready var player_red = $PlayerRed
onready var player_blue = $PlayerBlue
onready var message_timer = $MessageTimer
onready var title_lbl = $TitleLbl
onready var left_arrow = $LeftBtn
onready var right_arrow = $RightBtn

var idx = 0
var text_idx = 0
var message = "Welcome Space Hero! Choose Your Spaceship!"

var adventure_game = load("res://scenes/Adventure.tscn")

func _ready():
	message_timer.start()
	
func _process(delta):
	if idx == 0:
		player_red.hide()
		player_blue.show()
		right_arrow.show()
		left_arrow.hide()
		GLOBALS.color = 0
	elif idx == 1:
		player_red.show()
		player_blue.hide()
		right_arrow.hide()
		left_arrow.show()
		GLOBALS.color = 1
	
	if Input.is_action_just_pressed("move_left"):
		if idx > 0:
			idx -= 1
	elif Input.is_action_just_pressed("move_right"):
		if idx < 1:
			idx += 1
	
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to(adventure_game)

func _on_MessageTimer_timeout():
	if text_idx < message.length():
		title_lbl.text += message[text_idx]
		text_idx += 1
		message_timer.start()
	
