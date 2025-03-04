extends Node

var audioState = true
@onready var audioButton = $"../AudioMuteButton"
@onready var musicPlayer = $"../MusicStreamPlayer2D"


func _ready() -> void:
	audioButton.button_pressed = true
	self.visible = true

func _on_start_button_pressed() -> void:
	GameManager.startGame()
	self.visible = false

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func muteAudio():
	if audioState == true:
		audioState = false
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"),true)
	elif audioState == false:
		audioState = true
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"),false)


func _on_music_stream_player_2d_finished() -> void:
	musicPlayer.play()
