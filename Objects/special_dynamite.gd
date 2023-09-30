extends StaticBody2D

var placed = false
var explosion_radius = 1.5
@export var dynamite_price = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	set_collision_layer_value(2,false)
	set_collision_mask_value(2,false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("place"):
		set_collision_layer_value(2,true)
		set_collision_mask_value(2,true)
		placed = true
		modulate.a = 1
		var explosion = load("res://Objects/explosion.tscn").instantiate()
		explosion.position = position
		explosion.get_node("Sprite2D").get_node("AnimationPlayer").play("explosion")
		explosion.scale.x += explosion_radius -1 
		explosion.scale.y += explosion_radius -1
		get_parent().add_child(explosion)
		await get_tree().create_timer(0.1).timeout
		queue_free()
		
	if not placed:
		set_collision_layer_value(2,false)
		set_collision_mask_value(2,false)
		position = get_global_mouse_position()
		modulate.a = 0.6
	if Input.is_action_just_pressed("craft") and not placed:
		get_tree().get_nodes_in_group("Player")[0].diamond += dynamite_price
		queue_free()
	pass
