extends KinematicBody2D

onready var hurtbox = $Hurtbox
onready var animations = $AnimatedSprite

const MAX_SPEED : float = 200.0
const JUMP_H : float = -500.0
const GRAVITY : float = 25.0
const UP := Vector2(0, -1)

var motion := Vector2()

var _is_able_to_jump : bool
var _jump_was_pressed : bool


func _ready() -> void:
	animations = $AnimatedSprite
	_is_able_to_jump = true
	pass

func _physics_process(_delta) -> void:
	motion.y += GRAVITY
	
	_get_input()
	
	motion = move_and_slide(motion, UP)

func _get_input() -> void:
	if Input.is_action_pressed("ui_right"):
		animations.animation = "walk"
		motion.x = MAX_SPEED
		$AnimatedSprite.scale.x = 1
	elif Input.is_action_pressed("ui_left"):
		animations.animation = "walk"
		motion.x = -MAX_SPEED
		$AnimatedSprite.scale.x = -1
	else:
		animations.animation = "idle"
		motion.x = 0

	if Input.is_action_just_pressed("player_jump"):
		_jump_was_pressed = true
		_remember_jump_time()
		if _is_able_to_jump == true:
			
			motion.y = JUMP_H
				
	if is_on_floor():
		_is_able_to_jump = true
		
		if _jump_was_pressed == true:
			motion.y = JUMP_H
		pass
	else:
		animations.animation = "jump"
		_coyote_time()

		pass
	pass


func _coyote_time() -> void:
	yield(get_tree().create_timer(.1), "timeout")
	_is_able_to_jump = false

func _remember_jump_time() -> void:
	yield(get_tree().create_timer(.1), "timeout")
	_jump_was_pressed = false
