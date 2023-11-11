extends Node3D

@onready var oldend = $level/end.position + Vector3(0, 0, 1)
@onready var levels = [preload("res://Assets/Prefabs/level1.tscn")]
var delt = 2
var rand = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	choose_level()
	choose_level()
	choose_level()
	sound.music_level_start()

func choose_level():
#	var num = rand.randi() % 1
	var num = 0
	var lev = levels[num].instantiate()
	oldend += Vector3(0, 0, lev.beginadd)
	lev.position = oldend
	add_child(lev)
	print("new lev!")
	oldend += Vector3(rand.randf_range(-2, 2), 0, lev.endadd)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	delt += delta
	if delt > 1.5:
		delt = 0
		choose_level()
