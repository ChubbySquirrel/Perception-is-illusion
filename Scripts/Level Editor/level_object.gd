extends Node2D
class_name LevelObject

#This class is meant to be parent to all objects loadable into level editor
#The icon is used as their placeholder in the level editor to avoid instantiation issues

var icon: Icon


#position of object within the level grid
var level_grid_postiion: Vector2i = Vector2i.ZERO
