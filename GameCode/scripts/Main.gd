extends Node2D


onready var title_lbl = $TitleLbl
onready var welcome_lbl = $WelcomeLbl
onready var anim_player = $AnimationPlayer
onready var welcome_timer = $WelcomeCountdown
onready var game_menu = $GameMenu
onready var arrow1 = $GameMenu/Arrow1
onready var arrow2 = $GameMenu/Arrow2
onready var menu_animation = $GameMenuAnimation

var idx = 0
var menu_idx = 0
var show_menu = false

var welcome_message = "Welcome Fellow Space Adventurer\nChoose Your Next Space Adventure"
func _ready():
	anim_player.play("title_blink")
	welcome_timer.start()
	game_menu.hide()
	

func _process(delta):
	if show_menu:
		chose_game_style()	

func chose_game_style():
	if menu_idx == 0:
		arrow1.show()
		arrow2.hide()
		menu_animation.play("trivia")
	elif menu_idx == 1:
		arrow1.hide()
		arrow2.show()
		menu_animation.play("Collect")
		
	if Input.is_action_just_pressed("move_down"):
		if menu_idx < 1:
			menu_idx += 1
			menu_animation.play("RESET")
	elif Input.is_action_just_pressed("move_up"):
		if menu_idx > 0:
			menu_idx -= 1
			menu_animation.play("RESET")
		


func _on_WelcomeCountdown_timeout():
	welcome_lbl.text += welcome_message[idx]
	idx += 1
	if idx == welcome_message.length():
		game_menu.show()
		show_menu = true
	if idx < welcome_message.length():
		welcome_timer.start()

