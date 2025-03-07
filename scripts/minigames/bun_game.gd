extends Control

@onready var player = $CharacterBody2D
@onready var countLabel = $Label2
@onready var audioPlayer = $"/root/Control/AudioStreamPlayer2D"
var minigameNode

var movedRight = 0
var movedLeft = 0
var i = 0
var applecount = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	countLabel.text = "0"
	minigameNode = get_parent()
	await get_tree().create_timer(3).timeout
	#spawn apples
	spawnApple()
	#await the end of the game
	await get_tree().create_timer(45).timeout
	endGame()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left") && movedLeft != 10:
		#move player left
		player.position.x -= 15
		movedLeft += 1
		movedRight -= 1
	elif event.is_action_pressed("right") && movedRight != 10:
		#move player right
		player.position.x += 15
		movedLeft -= 1
		movedRight += 1

func spawnApple():
	var time = randf_range(0.25, 3)
	await get_tree().create_timer(time).timeout
	var newApple = load("res://objects/apple.tscn").instantiate()
	add_child(newApple)
	if i <= 3:
		i += 1
		spawnApple()
		
func endGame():
	if applecount <= 3:
		minigameNode.doneMinigame("fail")
	elif applecount >= 4 and applecount <= 9:
		minigameNode.doneMinigame("neutral")
	elif applecount >= 10 and applecount <= 15:
		minigameNode.doneMinigame("win")
	elif applecount >= 16:
		minigameNode.doneMinigame("perfect")

func hitApple(body) -> void:
	if body.is_in_group("collectable"):
		#collision with apple gives points
		audioPlayer.stream = load("res://sound/ding.mp3")
		audioPlayer.play()
		applecount += 1
		countLabel.text = str(applecount)
		body.queue_free()
		spawnApple()
