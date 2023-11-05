extends CharacterBody3D

const ACCEL = 10
const DEACCEL = 30
@export
var SPEED = 5.0
const SPRINT_MULT = 2
const JUMP_VELOCITY = 4.5
@export
var MOUSE_SENSITIVITY = 0.06
@onready
var camera1 = $rotation_helper/rot/Camera3D
@onready var camera2 = $rotation_helper/rot/Camera3D2
@onready var camera3 = $rotation_helper/rot/Camera3D3
# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity = 5
@onready var anime = $nat/AnimationPlayer
var camera
var rotation_helper
var dir = Vector3.ZERO
var flashlight
@onready var cameras = [camera1, camera2, camera3]
var activecamera
func _ready():
	rotation_helper = $rotation_helper/rot
	var enabled
	var config = ConfigFile.new()
	# Load data from a file.
	var err = config.load("user://settings.cfg")
	for misc in config.get_sections():
		# Fetch the data for each section.
		enabled = config.get_value(misc, "defaultcamera_pov")
	if enabled:
		print("pov boy")
		activecamera = 0
	else:
		activecamera = 1
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	anime.play("Take 001", -1, 0.7)
	cameras[activecamera].current = true

func _input(event):
	# This section controls your player camera. Sensitivity can be changed.
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		#rotation_helper.rotate_x(deg_to_rad(event.relative.y * MOUSE_SENSITIVITY * -1))
		#$rotation_helper.rotate_y(deg_to_rad(event.relative.x * MOUSE_SENSITIVITY * -1))

		var camera_rot = rotation_helper.rotation
		camera_rot.x = clampf(camera_rot.x, -1.4, 1.4)
		rotation_helper.rotation = camera_rot
	
	# Release/Grab Mouse for debugging. You can change or replace this.
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# Flashlight toggle. Defaults to F on Keyboard.
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_F1:
			activecamera = (activecamera + 1) % 3
			cameras[activecamera].current = true
		if event.pressed and event.keycode == KEY_ESCAPE:
			get_tree().change_scene_to_file("res://Assets/Scenes/MainMenu.tscn")

func _physics_process(delta):
	var moving = false
	
	# Add the gravity. Pulls value from project settings.

	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# This just controls acceleration. Don't touch it.
	var accel
	if dir.dot(velocity) > 0:
		accel = ACCEL
		moving = true
	else:
		accel = DEACCEL
		moving = true


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with a custom keymap depending on your control scheme. These strings default to the arrow keys layout.

		

	if Input.is_action_pressed("left"):
		velocity.x = 7 * delta * SPEED
	elif Input.is_action_pressed("right"):
		velocity.x = -7 * delta * SPEED
	velocity.z = 10 * delta * SPEED
	$nat.velocity.z = 10 * delta * SPEED * -1
	if not anime.is_playing:
		$nat.position = Vector3(0, 0, 0)
		anime.play("Take 001")
		
	if Input.is_key_pressed(KEY_SHIFT):
		velocity.x = velocity.x * SPRINT_MULT
	move_and_slide()
	velocity.x = 0
