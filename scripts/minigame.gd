extends Control

#after minigame -> show result, timer

@onready var resultScreen = $ResultRect
@onready var resultPastry = $ResultRect/TextureRect
@onready var resultEffect = $ResultRect/resultEffect
var order:String
var orderScene
var minigameScene
var points

signal space_pressed()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false

func startMinigame(orderPastry):
	self.visible = true
	resultScreen.visible = false
	resultEffect.visible = false
	order = orderPastry
	orderScene = "res://scenes/" + order + "Game.tscn"
	#instantiate the correct minigame scene
	minigameScene = load(orderScene).instantiate()
	add_child(minigameScene)

#show result overlay (fail, neutral, win, perfect)
func doneMinigame(result):
	if result == "fail":
		resultScreen.texture = load("failScreen")
		var pastry = "res://assets/items/" + order + "Fail.png"
		resultPastry.texture = load(pastry)
		points = 2
	elif result == "neutral":
		resultScreen.texture = load("neutralScreen")
		points = 5
	elif result == "win":
		resultScreen.texture = load("winScreen")
		points = 8
	elif result == "perfect":
		resultScreen.texture = load("winScreen")
		points = 10
		resultEffect.visible = true
	resultScreen.visible = true
	if minigameScene != null:
		minigameScene.queue_free()
		closeMinigame()

#emit signal if space is pressed
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("advance_dialogue"):
		space_pressed.emit()

#close minigame overlay
func closeMinigame():
	get_tree().create_timer(30).timeout.connect(func(): space_pressed.emit())
	await space_pressed
	if resultScreen.visible == true:
		self.visible = false
		GameManager.doneOrder(points, order)
