extends Node

var items_collected : Dictionary[String, int]
var tools_used : Dictionary[DataTypes.ToolTypes, int]
var objects_destroyed : Dictionary[String, int]
var crops_harvested : Dictionary[String, int]

func add_items_to_collected(item_name: String, amount: int) -> void:
	if item_name in items_collected:
		items_collected[item_name] += amount
	else:
		items_collected[item_name] = amount
	print(len(items_collected.keys()))

func add_used_tool(tool: DataTypes.ToolTypes, amount: int) -> void:
	if tool in tools_used:
		tools_used[tool] += amount
	else:
		tools_used[tool] = amount
	
func add_destroyed_object(object_name: String, amount: int) -> void:
	if object_name in objects_destroyed:
		objects_destroyed[object_name] += amount
	else:
		objects_destroyed[object_name] = amount

func add_harvested_crop(crop_name: String, amount: int) -> void:
	if crop_name in crops_harvested:
		crops_harvested[crop_name] += amount
	else:
		crops_harvested[crop_name] = amount

func get_collected_items_string() -> String:
	var result: String = "Collected Items\n\n"
	for key in items_collected.keys():
		result += (key + ": " + str(items_collected[key]) + "\n")
	return result

func get_used_tools_string() -> String:
	var result: String = "Used Tools\n\n"
	for key in tools_used.keys():
		result += (DataTypes.ToolNames[key] + ": " + str(tools_used[key]) + "\n")
	return result

func get_destroyed_objects_string() -> String:
	var result: String = "Destroyed Objects\n\n"
	for key in objects_destroyed.keys():
		result += (key + ": " + str(objects_destroyed[key]) + "\n")
	return result

func get_harvested_crops_string() -> String:
	var result: String = "Harvested Crops\n\n"
	for key in crops_harvested.keys():
		result += (key + ": " + str(crops_harvested[key]) + "\n")
	return result
