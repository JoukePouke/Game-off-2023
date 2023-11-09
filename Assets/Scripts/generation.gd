extends Node3D

@onready var oldend = $level/end.position
@onready var newstart = oldend + Vector3(oldend.x, oldend.y, oldend.z + 5)
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
	lev.position = newstart
	add_child(lev)
	print("new lev!")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	delt += delta
	if delt > 3:
		delt = 0
		choose_level()
