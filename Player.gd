extends KinematicBody2D

const ACCELERATION = 50
const GRAVITY = 20
const JUMP_HEIGHT = -550
const MAX_SPEED = 350
const UP = Vector2(0, -1)

var motion = Vector2()

func _physics_process(_delta):
	motion.y += GRAVITY
	var friction = false

	# Moving left and right
	if Input.is_action_pressed("dpad_right"):
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed("dpad_left"):
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		friction = true
		$Sprite.play("Idle")

	# Pressing "A" will make Slink jump.
	if is_on_floor():
		if Input.is_action_just_pressed("a"):
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if motion.y < 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)

	if Input.is_action_just_pressed("start"):
		get_tree().quit()

	motion = move_and_slide(motion, UP)
	pass
