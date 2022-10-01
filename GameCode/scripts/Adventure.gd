extends Node2D


onready var bg = $Bg

var textures = [
	preload('res://assets/background/seemless/Blue Nebula/Blue Nebula 1 - 512x512.png'),
	preload('res://assets/background/seemless/Blue Nebula/Blue Nebula 2 - 512x512.png'),
	preload('res://assets/background/seemless/Blue Nebula/Blue Nebula 3 - 512x512.png'),
	preload('res://assets/background/seemless/Blue Nebula/Blue Nebula 4 - 512x512.png'),
	preload('res://assets/background/seemless/Blue Nebula/Blue Nebula 5 - 512x512.png'),
	preload('res://assets/background/seemless/Blue Nebula/Blue Nebula 6 - 512x512.png'),
	preload('res://assets/background/seemless/Blue Nebula/Blue Nebula 7 - 512x512.png'),
	preload('res://assets/background/seemless/Blue Nebula/Blue Nebula 8 - 512x512.png'),
	preload('res://assets/background/seemless/Green Nebula/Green Nebula 1 - 512x512.png'),
	preload('res://assets/background/seemless/Green Nebula/Green Nebula 2 - 512x512.png'),
	preload('res://assets/background/seemless/Green Nebula/Green Nebula 3 - 512x512.png'),
	preload('res://assets/background/seemless/Green Nebula/Green Nebula 4 - 512x512.png'),
	preload('res://assets/background/seemless/Green Nebula/Green Nebula 5 - 512x512.png'),
	preload('res://assets/background/seemless/Green Nebula/Green Nebula 6 - 512x512.png'),
	preload('res://assets/background/seemless/Green Nebula/Green Nebula 7 - 512x512.png'),
	preload('res://assets/background/seemless/Green Nebula/Green Nebula 8 - 512x512.png'),
	preload('res://assets/background/seemless/Purple Nebula/Purple Nebula 1 - 512x512.png'),
	preload('res://assets/background/seemless/Purple Nebula/Purple Nebula 2 - 512x512.png'),
	preload('res://assets/background/seemless/Purple Nebula/Purple Nebula 3 - 512x512.png'),
	preload('res://assets/background/seemless/Purple Nebula/Purple Nebula 4 - 512x512.png'),
	preload('res://assets/background/seemless/Purple Nebula/Purple Nebula 5 - 512x512.png'),
	preload('res://assets/background/seemless/Purple Nebula/Purple Nebula 6 - 512x512.png'),
	preload('res://assets/background/seemless/Purple Nebula/Purple Nebula 7 - 512x512.png'),
	preload('res://assets/background/seemless/Purple Nebula/Purple Nebula 8 - 512x512.png'),
	preload('res://assets/background/seemless/Starfields/Starfield 1 - 512x512.png'),
	preload('res://assets/background/seemless/Starfields/Starfield 2 - 512x512.png'),
	preload('res://assets/background/seemless/Starfields/Starfield 3 - 512x512.png'),
	preload('res://assets/background/seemless/Starfields/Starfield 4 - 512x512.png'),
	preload('res://assets/background/seemless/Starfields/Starfield 5 - 512x512.png'),
	preload('res://assets/background/seemless/Starfields/Starfield 6 - 512x512.png'),
	preload('res://assets/background/seemless/Starfields/Starfield 7 - 512x512.png'),
	preload('res://assets/background/seemless/Starfields/Starfield 8 - 512x512.png'),
	
	
]
var main_menu = load("res://scenes/Main.tscn")
onready var game_over_lbl = $GameOverLbl
var menu_scene = load('res://scenes/Main.tscn')
onready var astroid_path = $AstroidPath
onready var astroid_location = $AstroidPath/AstroudLocation
var spawn_time = 1
var score = 0
onready var score_lbl = $Scorelbl
onready var star_lbl = $StarScoreLbl
var star_count = 0
var star_scene = preload("res://scenes/Star.tscn")
var astroid_scene = preload("res://scenes/Astroid.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	GLOBALS.connect("take_star", self, "count_stars")
	GLOBALS.connect("player_death",self, "game_over")
	random_bg()
	$BgTimer.start()
	$SpawnTimer.start(spawn_time)
	game_over_lbl.hide()

func count_stars():
	star_count += 1
	star_lbl.text = str(star_count)
	
func random_bg():
	bg.texture = textures[randi() % textures.size()]

func _on_BgTimer_timeout():
	random_bg()
	$BgTimer.start()

func create_astroid():
	var astroid_obj = astroid_scene.instance()
	astroid_location.offset = randi()
	astroid_obj.position = astroid_location.position
	
	add_child(astroid_obj)

	

func _on_SpawnTimer_timeout():
	create_astroid()
	if score % 20 == 0 and spawn_time > 0.4:
		spawn_time -= 0.2
		
	$SpawnTimer.start(spawn_time)


func _on_ScoreTimer_timeout():
	score += 1
	score_lbl.text = "Score:" + str(score)


func _on_StarTimer_timeout():
	var star_obj = star_scene.instance()
	astroid_location.offset = randi()
	star_obj.position = astroid_location.position
	add_child(star_obj)
	

func game_over():
	get_tree().paused = true
	game_over_lbl.show()
	yield(get_tree().create_timer(2),"timeout")
	get_tree().change_scene_to(menu_scene)
	

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to(main_menu)
