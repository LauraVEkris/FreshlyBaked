extends Node

var days:int
var time:float
var points:int
var neededPoints:int
var customer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	days = 0
	points = 0
	customer = $Customer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func nextDay():
	if neededPoints == points:
		#start next day
		neededPoints = neededPoints + 50
		points = 0
		customer.shuffleArr()
	else:
		#restart day
		points = 0
