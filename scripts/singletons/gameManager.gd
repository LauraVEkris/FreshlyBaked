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
	neededCustomers = 3

func startGame():
	#start the first day
	lines = ["Your first day in a new town, with new people",
	"you enter your bakery, ready for a fresh start"]
	DialogueManager.startDialogue(lines)
	await DialogueManager.deletedBox
	#wait 3 seconds before first customer
	await get_tree().create_timer(3).timeout
	customer.newCustomer()

#process that an order was finished
func doneOrder(gainedPoints:int, order):
	if order != customer.order: return
	#make sure to delete the order
	DialogueManager.deleteTextbox()
	#add points and finish up with customer
	points += gainedPoints
	await get_tree().create_timer(2).timeout
	customer.doneOrder()

func nextDay():
	if neededPoints == points:
		#start next day
		neededPoints += 25
		neededCustomers += randi_range(-1,3)
		points = 0
		customer.shuffleArr()
	else:
		#restart day
		points = 0
		customer.restartDay()
