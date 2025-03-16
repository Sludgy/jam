extends Control

@export var id: int
@export var operation: bool

signal add_subtract_button_pressed(id: int, operation: bool)

func _on_pressed() -> void:
	add_subtract_button_pressed.emit(id, operation)
