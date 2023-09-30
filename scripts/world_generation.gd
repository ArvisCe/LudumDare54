extends Node2D

var bedrock = preload("res://Objects/Bedrock.tscn")
var cave_nodes = preload("res://Objects/cave_node.tscn")
var tiles = [
	["stone1",0],
	["stone2",1],
	["diamond",2],
	["gold",3]
]

@export var tile_size = 8

@export var world_radius = 80

var world = []
var generated = false
var rng = RandomNumberGenerator.new()


func _physics_process(delta):
	if not generated:
		var x_end = world_radius * tile_size
		var y_end = world_radius * tile_size
		var x_start = x_end * -1
		var y_start = y_end * -1
		for x in range(x_start,x_end+tile_size,tile_size):
			for y in range(y_start,y_end+tile_size,tile_size):
				var random_block = rng.randi_range(1,100)
				var block = cave_nodes.instantiate()
				var random_choice 					
				if random_block == 1:
					random_choice = 2
				elif random_block >= 2 and random_block < 8:
					random_choice = 3
				elif random_block < 50:
					random_choice = 0
				else:
					random_choice = 1
				block.get_node("Sprite2D").frame = tiles[random_choice][1]
				block.position.x = x
				block.position.y = y
				var disabled = false
				if x == -tile_size or x == tile_size or x == 0:
					if y == -tile_size or y == tile_size or y == 0:
						disabled = true
				if not disabled:
					get_owner().add_child(block)
				world.append([block,x,y])
		generated = true
		for x in range(x_start,x_end+tile_size,tile_size):
			var bedrock_instance = bedrock.instantiate()
			bedrock_instance.position.x = x
			bedrock_instance.position.y = y_start - 1
			var bedrock_instance2 = bedrock.instantiate()
			bedrock_instance2.position.x = x
			bedrock_instance2.position.y = y_end + 1
			get_owner().add_child(bedrock_instance)
			get_owner().add_child(bedrock_instance2)
		for y in range(y_start,y_end+tile_size,tile_size):
			var bedrock_instance = bedrock.instantiate()
			bedrock_instance.position.y = y
			bedrock_instance.position.x = x_start - 1
			var bedrock_instance2 = bedrock.instantiate()
			bedrock_instance2.position.y = y
			bedrock_instance2.position.x = x_end + 1
			get_owner().add_child(bedrock_instance)
			get_owner().add_child(bedrock_instance2)
func get_block(position):
	for i in range(world.size()):
		if world[i][1] == position.x:
			if world[i][2] == position.y:
				return world[i][0]
	return null
