@tool
extends Node2D

@export var gap_percent: float = 25.0:
	set(val):
		gap_percent = val
		_layout()
@export var gap_offset: float = 0:
	set(val):
		gap_offset = val
		_layout()


@onready var fallback_pipe_height: float = get_viewport_rect().size.y / 2
@onready var upper_pipe: Sprite2D = $upperPipe
@onready var lower_pipe: Sprite2D = $lowerPipe

func _ready() -> void:
	get_viewport().size_changed.connect(_layout)
	_layout()

func _layout() -> void:
	if not is_inside_tree():
		return
	var screen_h := get_viewport_rect().size.y
	var gap := screen_h * gap_percent / 100.0
	var gap_center := screen_h * gap_offset / 100 
	var pipe_h := _pipe_height()
		
	upper_pipe.position.y = -gap / 2.0 - pipe_h / 2.0 + gap_center
	lower_pipe.position.y =  gap / 2.0 + pipe_h / 2.0 + gap_center

func _pipe_height() -> float:
	if upper_pipe.texture != null:
		return float(upper_pipe.texture.get_height())
	return fallback_pipe_height
