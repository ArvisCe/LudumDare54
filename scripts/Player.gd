extends CharacterBody2D


@export var speed = 300.0
@export var jump_power = -400
@export var gravity_strength = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var throwing = false

func throw():
	var dynamite = load("res://Objects/dynamite.tscn").instantiate()
	dynamite.position = get_node("throw-position").global_position
	get_parent().add_child(dynamite)
	print("threw")
	
func _physics_process(delta):
	var animator = get_node("Sprite2D").get_node("AnimationPlayer")
	if Input.is_action_pressed("throw") or throwing:
		if not throwing:
			throw()
		animator.play("throw")
	elif not is_on_floor():
		velocity.y += gravity * delta
		animator.play("jump")
	elif not throwing:
		if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
			var direction = Input.get_axis("left", "right")
			animator.play("move")
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
		if Input.is_action_pressed("jump") and is_on_floor():
			velocity.y = jump_power
	else:
		animator.play("idle")
	if throwing:
		velocity.x = move_toward(velocity.x,0,speed)
	if Input.is_action_pressed("left"):
		get_node("Sprite2D").scale.x = -1
	if Input.is_action_pressed("right"):
		get_node("Sprite2D").scale.x = 1
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
