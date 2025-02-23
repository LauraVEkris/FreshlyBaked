extends Node

#gameloop variables
var days:int
var time:float
var points:int
var neededPoints:int
var customer
var neededCustomers:int

#gamefeel variables
var lines:Array[String]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	days = 0
	points = 0
	#start the first day
	lines = ["Your first day in a new town, with new people",
	"you enter your bakery, ready for a fresh start"]
	DialogueManager.startDialogue(lines)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func nextDay():
	if neededPoints == points:
		#start next day
		neededPoints += 50
		neededCustomers += randi_range(-1,3)
		points = 0
		customer.shuffleArr()
	else:
		#restart day
		points = 0
		customer.restartDay()
