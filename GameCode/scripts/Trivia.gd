extends Node2D
"""
Notes to self: don't forget to set the text_index to 0
dont's forget to set question to empty string 
"""
onready var question = $QuestionLbl
onready var question_timer = $QuestionTimer
onready var bg = $Bg
onready var bg_timer = $BgTimer

onready var c_w_container = $CorrectWrongContainer
onready var c1 = $CorrectWrongContainer/C1
onready var c2 = $CorrectWrongContainer/C2
onready var c3 = $CorrectWrongContainer/C3

var correct_texture = preload('res://assets/UI/Ok_BTN.png')
var incorrect_texture = preload('res://assets/UI/Close_BTN.png')

onready var hint1 = $Hints/Hint
onready var hint2 = $Hints/Hint2
onready var hint3 = $Hints/Hint3

onready var answer_lbl = $AnswerLbl

var bg_texture = [
	preload('res://assets/background/Nebula Aqua-Pink.png'),
	preload('res://assets/background/Nebula Blue.png'),
	preload('res://assets/background/Nebula Red.png')
]

var main_menu = load("res://scenes/Main.tscn")
onready var audio_player = $AudioStreamPlayer
#index of the response on the fact
var rdx = 0
var id = null
var text_index = 0

func _ready():
	get_tree().paused = false
	randomize()
	id = get_random_fact_id()
	question_timer.start()
	bg.texture = bg_texture[randi() % bg_texture.size()]
	bg_timer.start()
	generate_hint(id)
	c_w_container.hide()

	
	
func get_random_fact_id():
	return randi() % FACTS.facts.size()


func check_answer(id):
	return rdx == FACTS.facts[id].answer

func generate_hint(id):
	hint1.text = FACTS.facts[id].hints["1"]
	hint2.text = FACTS.facts[id].hints["2"]
	hint3.text = FACTS.facts[id].hints["3"]

func _on_QuestionTimer_timeout():
	if text_index < FACTS.facts[id].question.length():
		question.text += FACTS.facts[id].question[text_index]
		text_index +=1


func _on_BgTimer_timeout():
	bg.texture = bg_texture[randi() % bg_texture.size()]
	bg_timer.start()


func _on_Hint1_pressed():
	rdx = 1
	display_answer()
	$NextQuestionTimer.start()
	audio_player.play()
	get_tree().paused = true
	show_correct_incorrect_texture()
	
func _on_Hint2_pressed():
	rdx = 2
	display_answer()
	$NextQuestionTimer.start()
	audio_player.play()
	get_tree().paused = true
	show_correct_incorrect_texture()
	
func _on_Hint3_pressed():
	rdx = 3
	display_answer()
	$NextQuestionTimer.start()
	audio_player.play()
	get_tree().paused = true
	show_correct_incorrect_texture()
	
func display_answer():
	if check_answer(id):
		answer_lbl.text = "Correct!"
	else:
		answer_lbl.text = "Incorrect!"

func _on_NextQuestionTimer_timeout():
	get_tree().paused = false
	c_w_container.hide()
	if FACTS.facts.size() > 0:
		FACTS.facts.remove(id)

		
	id = get_random_fact_id()
	question.text = ""
	answer_lbl.text = ""
	text_index = 0
	question_timer.start()
	generate_hint(id)

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to(main_menu)

func _on_AudioStreamPlayer_finished():
	audio_player.stop()

func show_correct_incorrect_texture():
	c1.texture = incorrect_texture
	c2.texture = incorrect_texture
	c3.texture = incorrect_texture
	if FACTS.facts[id].answer == 1:
		c1.texture = correct_texture
	elif FACTS.facts[id].answer == 2:
		c2.texture = correct_texture
	elif FACTS.facts[id].answer == 3:
		c3.texture = correct_texture
	c_w_container.show()
