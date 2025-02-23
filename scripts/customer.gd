extends TextureRect

var order:String
@export var looks:Array[String]
@export var orders:Array[String]
var lookInt:int
var doneCustomers

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.customer = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func doneOrder():
	DialogueManager.deleteTextbox()
	#next customer
	self.visible = false
	await get_tree().create_timer(5).timeout
	newCustomer()


func newCustomer():
	if doneCustomers == GameManager.neededCustomers:
		GameManager.nextDay()
		return
	if lookInt < looks.size() - 1:
		lookInt += 1
	self.texture = load(looks[lookInt]) #change to next customer
	self.visible = true
	#random order
	var max = orders.size() - 1
	var orderNR = randi_range(0,max)
	#start dialogue with order here (order is an image)
	DialogueManager.startOrder(orders[orderNR])
	

func shuffleArr():
	looks.shuffle()

func restartDay():
	lookInt = 0
	self.texture = load(looks[lookInt])
