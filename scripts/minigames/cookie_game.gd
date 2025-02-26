extends Control

@onready var timerNode = $Timer
var timer:SceneTreeTimer
var minigameNode
var tiles = 9
var mousePos
var heldNode
var NR

#start timer on ready
func _ready() -> void:
	minigameNode = get_parent()
	timer = get_tree().create_timer(90)
	await timer.timeout
	endGame()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timerNode.text = str(int(timer.time_left))
	mousePos = get_viewport().get_mouse_position()
	if heldNode != null:
		heldNode.position = mousePos
		#check if tile is put down in correct position
		var answerNode = get_node("GridContainer/tileFill" + str(NR))
		if heldNode.position == answerNode.global_position:
			answerNode.texture = heldNode.texture_normal
			heldNode.queue_free()
			heldNode = null
			tiles -= 1
			if tiles == 0:
				endGame()

#pick up and put down a tile
func holdTile(number):
	if heldNode != null:
		heldNode = null
		return
	NR = number
	var heldNodepath = "PuzzleTile" + str(number)
	heldNode = get_node(heldNodepath)

func endGame():
	if tiles != 0:
		minigameNode.doneMinigame("fail")
	elif tiles == 0:
		minigameNode.doneMinigame("win")
