extends TextureRect

var patience:int
var waiting:bool
var order:String
@export var looks:Array[String]
var lookInt:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	doneOrder()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func doneOrder():
	waiting = false
	self.visible = false
	await get_tree().create_timer(5).timeout
	newCustomer()


func newCustomer():
	if lookInt < looks.size() - 1:
		lookInt += 1
	var lookPath = looks[lookInt]
	self.texture = lookPath #change to next customer
	self.visible = true

func shuffleArr():
	looks.shuffle()
