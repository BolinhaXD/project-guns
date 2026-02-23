## Class that works like a Data Base 
## Holds a dictionary for the resources of the items that exist in the game
extends Node2D

## The dictionary thast holds the item resources
var cache : Dictionary = {}
 
## The folder where the resources are
@export_dir var item_folder
 
## Ready function that gets all the resources and puts them in the dictionary
func _ready():
	var folder = DirAccess.open(item_folder)
	folder.list_dir_begin()
 
	var file_name = folder.get_next()
 
	while file_name != "":
 
		cache[file_name] = load(item_folder + "/" + file_name)
 
		file_name = folder.get_next()
 
## Returns a resource on its id
func get_item(ID):
	return cache[ID + ".tres"]
