extends Area2D

@export var body : Node2D

static var hovered_popup

var is_dragging = false
var is_hovered = false

var mouse_offset : Vector2


func _process(delta):
	if is_dragging:
		var mousepos = get_viewport().get_mouse_position()
		body.position = mouse_offset + Vector2(mousepos.x, mousepos.y)


func toggle_hover(is_on):
	is_hovered = is_on
	print("Hover:", is_on)
	if is_on:
		hovered_popup = self
	elif hovered_popup == self:
		hovered_popup = null


func toggle_drag(is_on: bool):
	mouse_offset = body.position - get_viewport().get_mouse_position() 
	is_dragging = is_on
	print("Drag:", is_on)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			toggle_drag(event.pressed and is_hovered) 


func _on_mouse_entered() -> void:
	#if hovered_popup == null:
	toggle_hover(true)


func _on_mouse_exited() -> void:
	toggle_hover(false)


func _on_mouse_left_window():
	toggle_hover(false)
	toggle_drag(false)


func _notification(notif):
	match notif:
		NOTIFICATION_WM_MOUSE_EXIT:
			_on_mouse_left_window()
		NOTIFICATION_WM_MOUSE_ENTER:
			pass
