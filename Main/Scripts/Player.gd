extends CharacterBody2D

@onready var PlayerAnim = $CameraSmoothing/PlayerAnimatedSprite
@onready var Cshape = $Collisions

@export var SPEED = 250
@export var CROUCH_SPEED = 100
@export var JUMP_POWER = -350
@export var GRAVITY = 700
@export var FALL_GRAVITY = 1200
@export var FAST_FALL_GRAVITY = 3700

var Crouching = false
var Jump_Buffer = false
var was_on_floor

var Crouching_Cshape = preload("res://Main/Player/PlayerCrouchingCshape.tres")
var Standing_Cshape = preload("res://Main/Player/PlayerStandingCshape.tres")


func _physics_process(delta):
	if !is_on_floor():
		velocity.y += get_gravity(velocity) * delta
	
	if !Crouching:
		Jump()
	
	Look_up()
	get_input()
	Crouch()
	
	if !was_on_floor && is_on_floor():
		if Jump_Buffer:
			Jump_Buffer = false
			Jump()
	was_on_floor = is_on_floor()
	
	move_and_slide()

func get_input():
	var direction = Input.get_axis("Move_Left","Move_Right")
	if direction:
		velocity.x = direction * get_speed()
	else:
		velocity.x = direction * -get_speed()

func Look_up():
	if Input.is_action_pressed("Look_Up"):
		$Camera.position.y = -100
	else:
		$Camera.position.y = 0

func Crouch():
	if Input.is_action_pressed("Crouch") and is_on_floor():
		PlayerAnim.play("CROUCH")
		PlayerAnim.position.y = 5
		Cshape.shape = Crouching_Cshape
		Cshape.position.y = 5
		Crouching = true
	else:
		PlayerAnim.play("IDLE")
		PlayerAnim.position.y = 0
		Cshape.shape = Standing_Cshape
		Cshape.position.y = 0
		Crouching = false


func Jump():
	if Input.is_action_just_pressed("Jump") or Jump_Buffer:
		if is_on_floor():
			velocity.y += JUMP_POWER
		else:
			if !Jump_Buffer:
				Jump_Buffer = true
				$JumpBufferTimer.start()
	
	if Input.is_action_just_released("Jump"):
		if !is_on_floor():
			velocity.y /= 4

func get_speed():
	if !Crouching:
		return SPEED
	return CROUCH_SPEED 

func get_gravity(velocity: Vector2):
	if velocity.y <= 0:
		return GRAVITY
	if Input.is_action_pressed("Fast_Fall"):
		return FAST_FALL_GRAVITY
	return FALL_GRAVITY

func _on_jump_buffer_timer_timeout():
	Jump_Buffer = false
