extends Node2D

@export var tiles = [
	[load("res://Objects/dirt.tscn"),1]
]


@export var world_radius = 5

var world = []
var generated = false
var rng = RandomNumberGenerator.new()


func _physics_process(delta):
	if not generated:
		var x_end = world_radius * 32
		var y_end = world_radius * 32
		var x_start = x_end * -1
		var y_start = y_end * -1
		for x in range(x_start,x_end+32,32):
			for y in range(y_start,y_end+32,32):
				var random_block = rng.randi_range(0,tiles.size())-1
				var block = tiles[random_block][0].instantiate()
				block.position.x = x
				block.position.y = y
				var disabled = false
				if x == -32 or x == 32 or x == 0:
					if y == -32 or y == 32 or y == 0:
						disabled = true
				if not disabled:
					get_owner().add_child(block)
				world.append([block,x,y])
				print("X: "+str(x)+"  Y: "+str(y))
		generated = true
			
			
