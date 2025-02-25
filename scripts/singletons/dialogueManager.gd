extends Node

@onready var textboxScene = preload("res://objects/text_box.tscn")

var dialogueLines: Array[String] = []
var currentLineIndex = 0

var textbox
var textboxPosition: Vector2 = Vector2(556, 0)
var image

#state variables
var is_dialogue_active = false
var can_advance_line = false
signal deletedBox()

#start dialogue for text
func startDialogue(lines: Array[String]):
	if is_dialogue_active:
		return
	dialogueLines = lines
	showTextbox()
	
	is_dialogue_active = true


func showTextbox():
	textbox = textboxScene.instantiate()
	textbox.finished_displaying.connect(textboxFinishedDisplaying)
	get_tree().root.add_child(textbox)
	textbox.global_position = textboxPosition
	textbox.displayText(dialogueLines[currentLineIndex])
	can_advance_line = false


func textboxFinishedDisplaying():
	can_advance_line = true

#start dialogue, but for an order
func startOrder(order: String):
	if is_dialogue_active:
		return
	image = order
	showOrder()
	
	is_dialogue_active = true


func showOrder():
	textbox = textboxScene.instantiate()
	get_tree().root.add_child(textbox)
	textbox.global_position = textboxPosition
	textbox.displayOrder(image)
	can_advance_line = false


func _unhandled_input(event: InputEvent) -> void:
	if (
		event.is_action_pressed("advance_dialogue") &&
		is_dialogue_active &&
		can_advance_line
	):
		textbox.queue_free()
		currentLineIndex += 1
		if currentLineIndex >= dialogueLines.size():
			is_dialogue_active = false
			currentLineIndex = 0
			deletedBox.emit()
			return
		showTextbox()

#delete textbox manually and reset states
func deleteTextbox():
	is_dialogue_active = false
	can_advance_line = false
	deletedBox.emit()
	textbox.queue_free()
