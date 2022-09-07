extends Node

onready var fps = $Label

func _process(delta):
	fps.text = str(Engine.get_frames_per_second())
	
