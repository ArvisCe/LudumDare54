extends CharacterBody2D


@export var speed = 300.0
@export var jump_power = -400
@export var gravity_strength = 1
var dynamite_cooldown = 0
var dynamite_cooldown_reset = 1.5
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var throwing = false

@export var stone = 0
@export var diamond = 0
@export var gold = 0
var playerscale

@export var ammo = 10

func _ready():
	playerscale = get_node("Sprite2D").scale.x

func throw():
	var dynamite = load("res://Objects/dynamite.tscn").instantiate()
	dynamite.position = get_node("Sprite2D").get_node("throw-position").global_position
	ammo -= 1
	get_parent().add_child(dynamite)
	
func _physics_process(delta):
	dynamite_cooldown -= 1 * delta
	var animator = get_node("Sprite2D").get_node("AnimationPlayer")
	if not is_on_floor():
		velocity.y += gravity * delta * gravity_strength
	if Input.is_action_pressed("throw") or throwing :
		if dynamite_cooldown <= 0 and ammo > 0:
			if not throwing:
				throw()
				dynamite_cooldown = dynamite_cooldown_reset 
			animator.play("throw")
	elif not is_on_floor():
		animator.play("jump")
	elif not throwing:
		if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
			animator.play("move")
		if Input.is_action_pressed("jump") and is_on_floor():
			velocity.y = jump_power
	else:
		animator.play("idle")
	if throwing:
		velocity.x = move_toward(velocity.x,0,speed)
	if Input.is_action_pressed("left"):
		get_node("Sprite2D").scale.x = playerscale * -1
		velocity.x = -1 * speed
	elif Input.is_action_pressed("right"):
		get_node("Sprite2D").scale.x = playerscale
		velocity.x = 1 * speed
	else:
		velocity.x = 0
	if Input.is_action_pressed("go_down"):
		set_collision_layer_value(10,false)
		set_collision_mask_value(10,false)
	else:
		set_collision_layer_value(10,true)
		set_collision_mask_value(10,true)
	move_and_slide()

func _on_animation_player_animation_finished(anim_name):
	var animator = get_node("Sprite2D").get_node("AnimationPlayer")
	if anim_name == "throw":
		throwing = false
		animator.play("idle")
	animator.play("idle")
	pass # Replace with function body.


func _on_animation_player_animation_started(anim_name):
	if anim_name == "throw":
		throwing = true
	pass # Replace with function body.
