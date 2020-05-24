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
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed("dpad_left"):
		motion.x = -SPEED
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		motion.x = 0
		$Sprite.play("Idle")

	# Pressing "A" will make Slink jump.
	if is_on_floor():
		if Input.is_action_just_pressed("a"):
			motion.y = JUMP_HEIGHT
	else:
		$Sprite.play("Jump")

	if Input.is_action_just_pressed("start"):
		get_tree().quit()

	motion = move_and_slide(motion, UP)
	pass
