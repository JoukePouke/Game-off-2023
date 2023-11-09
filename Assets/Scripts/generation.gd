extends Node3D

@onready var oldend = $level/end.position
@onready var newstart = oldend + Vector3(oldend.x, oldend.y, oldend.z + 2)
@onready var levels = [preload("res://Assets/Prefabs/level1.tscn")]
var delt = 2
var rand = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	choose_level()
	choose_level()
	choose_level()

func choose_level():
#	var num = rand.randi() % 1
	var num = 0
	var lev = levels[num].instantiate()
	lev.position = newstart
	add_child(lev)
	print("new lev!")
	oldend = lev.get_node("level").position
	newstart = oldend + Vector3(oldend.x, oldend.y, oldend.z + 2)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	delt += delta
	if delt > 3:
		delt = 0
		choose_level()
