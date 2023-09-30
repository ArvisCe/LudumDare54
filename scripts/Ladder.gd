extends StaticBody2D

var ladder_placed = false
@export var ladder_price = 6
# Called when the node enters the scene tree for the first time.
func _ready():
	set_collision_layer_value(10,false)
	set_collision_mask_value(10,false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("place"):
		set_collision_layer_value(10,true)
		set_collision_mask_value(10,true)
		ladder_placed = true
		modulate.a = 1
	if not ladder_placed:
		set_collision_layer_value(10,false)
		set_collision_mask_value(10,false)
		position = get_global_mouse_position()
		modulate.a = 0.6
	if Input.is_action_just_pressed("craft") and not ladder_placed:
		get_tree().get_nodes_in_group("Player")[0].stone += 6
		queue_free()
	pass
