extends CharacterBody2D
@export var speed = 80
@export var explosion_radius = 0.8
var stopped = false
# Called when the node enters the scene tree for the first time.
func _ready():
	var throw = (get_global_mouse_position() - position).normalized()
	var throw_y = throw.y * speed
	var throw_x = throw.x * speed
	velocity.y = throw_y
	velocity.x = throw_x
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not stopped:
		velocity.y += 100 * delta
		move_and_slide()
	pass
func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("node"):
		stopped = true
		var explosion = load("res://Objects/explosion.tscn").instantiate()
		explosion.position = position
		explosion.get_node("Sprite2D").get_node("AnimationPlayer").play("explosion")
		explosion.scale.x += explosion_radius -1 
		explosion.scale.y += explosion_radius -1
		get_parent().add_child(explosion)
		await get_tree().create_timer(0.1).timeout
		queue_free()
	pass
