extends Node

var chunks : Array[CropChunk]

func add_crop(crop : Crop):
	var added : bool = false
	var chunk_pos : Vector2i = Vector2i(floor(crop.cell_pos.x/16), floor(crop.cell_pos.y/16))
	
	for i in range(len(chunks)):
		if chunks[i].chunk_pos == chunk_pos:
			chunks[i].add_crop(crop)
			added = true
			break
	
	if !added:
		var chunk = CropChunk.new()
		chunk.chunk_pos = chunk_pos
		chunk.add_crop(crop)
		chunks.append(chunk)

func remove_crop(cell_pos : Vector2i):
	var chunk_pos : Vector2i = Vector2i(floor(cell_pos.x/16), floor(cell_pos.y/16))
	
	for i in range(len(chunks)):
		if chunks[i].chunk_pos == chunk_pos:
			chunks[i].remove_crop(cell_pos)
			if !chunks[i].has_crops():
				chunks.remove_at(i)
			break

func try_to_water_crop(cell_pos : Vector2i) -> bool:
	var chunk_pos : Vector2i = Vector2i(floor(cell_pos.x/16), floor(cell_pos.y/16))

	for i in range(len(chunks)):
		if chunks[i].chunk_pos == chunk_pos:
			return chunks[i].try_to_water_crop(cell_pos)
			
	return false
