extends Control

@onready var player = $CharacterBody2D
var result = "fail"
var minigameNode
var tracking = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	minigameNode = get_parent()

#every frame, move player to mouse
func _process(delta: float) -> void:
	if !tracking: return
	var mousePos = get_viewport().get_mouse_position()
	player.position = mousePos

func hitCheck(body, grade:String):
	result = grade
	if grade == "perfect":
		minigameNode.doneMinigame(result)

#mouse entering shapes will kill the player and end the minigame
func death(body:Node2D) -> void:
	if body.is_in_group("player"):
		minigameNode.doneMinigame(result)


func startTracking() -> void:
	tracking = true
