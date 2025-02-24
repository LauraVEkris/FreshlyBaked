extends Node

func _ready() -> void:
	self.visible = true

func _on_start_button_pressed() -> void:
	GameManager.startGame()
	self.visible = false


func _on_quit_button_pressed() -> void:
	pass
