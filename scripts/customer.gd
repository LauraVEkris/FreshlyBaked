extends TextureRect

var order:String
@export var looks:Array[String]
@export var orders:Array[String]
var lookInt:int
var doneCustomers = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.customer = self
	self.visible = false

func doneOrder():
	#next customer
	self.visible = false
	GameManager.bag.visible = false
	doneCustomers += 1
	await get_tree().create_timer(5).timeout
	newCustomer()

func newCustomer():
	if doneCustomers >= GameManager.neededCustomers:
		GameManager.nextDay()
		return
	if lookInt < looks.size() - 1:
		lookInt += 1
	elif lookInt == looks.size() - 1:
		lookInt = 0
	self.texture = load(looks[lookInt]) #change to next customer
	self.visible = true
	#random order
	var maxNR = orders.size() - 1
	var orderNR = randi_range(0,maxNR)
	#start dialogue with order here (order is an image)
	order = orders[orderNR]
	var orderPath = "res://assets/items/" + order + ".png"
	DialogueManager.startOrder(orderPath)

func shuffleArr():
	looks.shuffle()

func restartDay():
	lookInt = 0
	doneCustomers = 0
	self.texture = load(looks[lookInt])
	newCustomer()
