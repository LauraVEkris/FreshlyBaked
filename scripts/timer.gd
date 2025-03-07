extends Control

@onready var label = $Label
@onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await timer.timeout
	GameManager.nextDay()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = str(int(timer.time_left))
