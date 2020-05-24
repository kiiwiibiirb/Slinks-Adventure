extends KinematicBody2D

const GRAVITY = 20
const JUMP_HEIGHT = -550
const SPEED = 350
const UP = Vector2(0, -1)

var motion = Vector2()

func _physics_process(delta):
	motion.y += GRAVITY

	# Moving left and right
	if Input.is_action_pressed("dpad_right"):
		motion.x = SPEED
	elif Input.is_action_pressed("dpad_left"):
		motion.x = -SPEED
	else:
		motion.x = 0

	# Pressing "A" will make Slink jump.
	if is_on_floor():
		if Input.is_action_just_pressed("a"):
			motion.y = JUMP_HEIGHT

	if Input.is_action_just_pressed("select"):
		get_tree().quit()

	motion = move_and_slide(motion, UP)
	pass
