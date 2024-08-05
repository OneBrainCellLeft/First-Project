extends CharacterBody2D

@onready var PlayerAnim = $CameraSmoothing/PlayerAnimatedSprite
@onready var Cshape = $Collisions
@onready var CEdetect1 = $CeillingDetection
@onready var CEdetect2 = $CeillingDetection2
@onready var Btimer = $JumpBufferTimer
@onready var Ctimer = $CoyoteTimer
@onready var UpperSDR = $UpperStepDetectionRight
@onready var UpperSDL = $UpperStepDetectionLeft
@onready var LowerSDR = $LowerStepDetectionRight
@onready var LowerSDL = $LowerStepDetectionLeft

@export var SPEED = 250
@export var CROUCH_SPEED = 100
@export var JUMP_POWER = -350
@export var GRAVITY = 700
@export var FALL_GRAVITY = 1200
@export var FAST_FALL_GRAVITY = 3700

var Crouching_Cshape = preload("res://Main/Player/PlayerCrouchingCshape.tres")
var Standing_Cshape = preload("res://Main/Player/PlayerStandingCshape.tres")

var Crouching = false
var Coyote_Time = false
var Jump_Buffer = false
var Coyote_Jump = false
var was_on_floor


func _physics_process(delta):
	if !is_on_floor() and !Coyote_Jump:
		velocity.y += get_gravity() * delta
	
	if !Crouching:
		Jump()
	
	Utils.Triangle_Valid()
	Move()
	Step_up()
	Look_up_or_down()
	Crouch()
	
	if !was_on_floor && is_on_floor():
		if Jump_Buffer:
			Jump_Buffer = false
			Jump()
	
	was_on_floor = is_on_floor()
	move_and_slide()
	if was_on_floor and !is_on_floor() and velocity.y >= 0:
		Coyote_Jump = true
		Ctimer.start()


func Move():
	var direction = Input.get_axis("Move_Left","Move_Right")
	if direction:
		velocity.x = direction * get_speed()
	else:
		velocity.x = direction * -get_speed()


func Look_up_or_down():
	if Input.is_action_pressed("Look_Up"):
		$Camera.position.y = -150
	elif Input.is_action_pressed("Look_Down"):
		$Camera.position.y = +150
	else:
		$Camera.position.y = 0


func Crouch():
	if Input.is_action_pressed("Crouch") and is_on_floor():
		PlayerAnim.play("CROUCH")
		PlayerAnim.position.y = 5
		Cshape.shape = Crouching_Cshape
		Cshape.position.y = 5
		Crouching = true
	elif !CEdetect1.is_colliding() and !CEdetect2.is_colliding():
		PlayerAnim.play("IDLE")
		PlayerAnim.position.y = 0
		Cshape.shape = Standing_Cshape
		Cshape.position.y = 0
		Crouching = false


func Jump():
	if Input.is_action_just_pressed("Jump") or Jump_Buffer:
		if is_on_floor() or Coyote_Jump:
			velocity.y += JUMP_POWER
			if Coyote_Jump:
				Coyote_Jump = false
		elif !Jump_Buffer:
			Jump_Buffer = true
			Btimer.start()
	
	if Input.is_action_just_released("Jump"):
		if !is_on_floor():
			velocity.y /= 4


func Step_up():
	if !UpperSDR.is_colliding() and LowerSDR.is_colliding() or !UpperSDL.is_colliding() and LowerSDL.is_colliding():
		velocity.y = -100

func get_speed():
	if !Crouching:
		return SPEED
	return CROUCH_SPEED 


func get_gravity():
	if velocity.y <= 0:
		return GRAVITY
	if Input.is_action_pressed("Fast_Fall"):
		return FAST_FALL_GRAVITY
	return FALL_GRAVITY


func _on_jump_buffer_timer_timeout():
	Jump_Buffer = false


func _on_coyote_timer_timeout():
	Coyote_Jump = false
