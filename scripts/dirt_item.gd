extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
@export var item = 0
@export var speed = 0
func _ready():
	get_node("Sprite2D").frame = item
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_on_floor():
		velocity.y += 2
	else:
		velocity.y = 0
	move_and_slide()
	pass


func _on_pickup_body_entered(body):
	if body.is_in_group("Player"):
		match(item):
			0:
				body.stone += 1
			1:
				body.stone += 1
			2: 
				body.diamond += 1
			3: 
				body.gold += 1
		queue_free()
	pass
