extends CharacterBody2D

@export var throw_x = 200
@export var throw_y = -100
@export var throw_decay_x = 150
@export var throw_decay_y = 170
# Called when the node enters the scene tree for the first time.
func _ready():
	velocity.y = throw_y
	velocity.x = throw_x
	var player = get_tree().get_nodes_in_group("player")[0]
	if player.scale.x == -1:
		velocity.x = throw_x * -1
		scale.x = -1
	else:
		velocity.x = throw_x
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player = get_tree().get_nodes_in_group("player")[0]
	velocity.y += throw_decay_y * delta
	velocity.x -= throw_decay_x * delta
	if velocity.x <= 0:
		velocity.x = 0
	if velocity.x != 0 and velocity.y != 0:
		move_and_slide()
	pass


func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("dirt"):
		velocity.y = 0
		velocity.x = 0
		await get_tree().create_timer(1).timeout
		queue_free()
		print("dirt")
	print("other")
	pass # Replace with function body.
