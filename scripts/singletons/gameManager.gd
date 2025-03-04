extends Node

#gameloop variables
var days:int
var time:float
var points:int
var neededPoints:int
var customer
var neededCustomers:int
var countdown

#gamefeel variables
var lines:Array[String]
var pointsLabel:Label
var dayLabel:Label
var bag
var cutscene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	days = 1
	points = 0
	neededCustomers = 3
	neededPoints = 13

func startGame():
	#setting up nodes
	bag = $/root/Control/Display/bagRect
	bag.visible = false
	pointsLabel = $"/root/Control/pointsLabel"
	dayLabel = $"/root/Control/dayLabel"
	pointsLabel.text = "points: " + str(points) + "/" + str(neededPoints)
	dayLabel.text = "day: " + str(days)
	cutscene = $/root/Control/cutsceneRect
	
	#start the first day
	lines = ["Moving to a new town, with new strangers and new opportunities",
	"You enter your bakery, ready for a fresh start"]
	cutscene.visible = true
	DialogueManager.startDialogue(lines)
	await DialogueManager.deletedBox
	cutscene.visible = false
	#wait 3 seconds before first customer
	await get_tree().create_timer(3).timeout
	customer.newCustomer()

#process that an order was finished
func doneOrder(gainedPoints:int, order):
	if order != customer.order: return
	#make sure to delete the order
	DialogueManager.deleteTextbox()
	#add points and finish up with customer
	bag.visible = true
	points += gainedPoints
	pointsLabel.text = "points: " + str(points) + "/" + str(neededPoints)
	await get_tree().create_timer(2).timeout
	customer.doneOrder()

func nextDay():
	if countdown != null:
		countdown.queue_free()
		countdown = null
	if points >= neededPoints:
		#start next day
		days += 1
		dayLabel.text = "day: " + str(days)
		neededPoints += 20
		neededCustomers += 2
		points = 0
		pointsLabel.text = "points: " + str(points) + "/" + str(neededPoints)
		customer.shuffleArr()
		customer.restartDay()
	else:
		#restart day
		points = 0
		pointsLabel.text = "points: " + str(points) + "/" + str(neededPoints)
		customer.restartDay()
	if days >= 5:
			countdown = load("res://objects/timer.tscn").instantiate()
			var controlNode = $"/root/Control"
			controlNode.add_child(countdown)
