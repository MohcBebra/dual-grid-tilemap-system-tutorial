extends TileMapLayer

@onready var corners_to_tile_source: Dictionary[Array, Vector2i] = {[0,1,0,0] : Vector2i(0,0),
												[0,0,1,1] : Vector2i(1,0),
												[1,1,0,1] : Vector2i(2,0),
												[0,1,0,1] : Vector2i(3,0),
												[1,0,0,1] : Vector2i(0,1),
												[0,1,1,1] : Vector2i(1,1),
												[1,1,1,1] : Vector2i(2,1),
												[1,1,1,0] : Vector2i(3,1),
												[0,0,1,0] : Vector2i(0,2),
												[1,0,1,0] : Vector2i(1,2),
												[1,0,1,1] : Vector2i(2,2),
												[1,1,0,0] : Vector2i(3,2),
												[0,0,0,1] : Vector2i(1,3),
												[0,1,1,0] : Vector2i(2,3),
												[1,0,0,0] : Vector2i(3,3),}

func _ready():
	var world_tiles: Array = self.get_used_cells_by_id(0, Vector2i(0,0), 0)
	if world_tiles != []:
		for world_tile in world_tiles:
			place_visual_tile(world_tile)

func place_visual_tile(tile_coords: Vector2i):
	for x: int in range(2):
		for y: int in range(2):
			var corners: Array = get_tile_corners(tile_coords + Vector2i(x,y))
			var atlas_coords: Vector2i = corners_to_tile_source.get(corners)
			$VisualLayer.set_cell(tile_coords + Vector2i(x,y), 0, atlas_coords, 0)

func get_tile_corners(coords: Vector2i):
	var corners := [0,0,0,0]
	var i := 0
	for x: int in range(2):
		for y: int in range(2):
			var neighbor = self.get_cell_atlas_coords(coords - Vector2i(1,1) + Vector2i(x,y))
			if neighbor == Vector2i(0,0):
				corners[i] = 1
			else:
				corners[i] = 0
			i += 1
	return(corners)



"""
func place_visual_tile(tile_coords: Vector2i, world_tile_atlas_coords: Vector2i, visual_layer: TileMapLayer):
	for x: int in range(2):
		for y: int in range(2):
			var corners: Array = get_tile_corners(tile_coords + Vector2i(x,y), world_tile_atlas_coords)
			var atlas_coords: Vector2i = corners_to_tile_source.get(corners)
			visual_layer.set_cell(tile_coords + Vector2i(x,y), 0, atlas_coords, 0)

func get_tile_corners(coords: Vector2i, world_tile_atlas_coords: Vector2i):
	var corners := [0,0,0,0]
	var i := 0
	var neighbor := Vector2i(0,0)
	for x: int in range(2):
		for y: int in range(2):
			neighbor = self.get_cell_atlas_coords(coords - Vector2i(1,1) + Vector2i(x,y))
			if (neighbor == world_tile_atlas_coords) or (neighbor == world_tile_atlas_coords + Vector2i(1,0)):
				corners[i] = 1
			else:
				corners[i] = 0
			i += 1
	return(corners)
"""
