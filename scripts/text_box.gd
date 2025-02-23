extends MarginContainer

#variables for showing dialogues/orders
@onready var label = $MarginContainer/Label
@onready var texture = $MarginContainer/TextureRect
#other variables
@onready var timer = $LetterDisplayTimer

const MAX_WIDTH = 256
var text = ""
var letterIndex = 0
#timing
var letterTime = 0.03
var spaceTime = 0.06
var punctuationTime = 0.2

signal finished_displaying()


#display a dialogue in text
func displayText(text_to_display: String):
	text = text_to_display
	label.text = text_to_display
	
	await resized
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized #await x resize
		await resized #await y resize
		custom_minimum_size.y = size.y
	
	global_position.x -= size.x / 2
	global_position.y -= size.y + 25
	
	label.text = ""
	displayLetter()


func displayLetter():
	label.text += text[letterIndex]
	letterIndex += 1
	if letterIndex >= text.length():
		finished_displaying.emit()
		return
	
	match text[letterIndex]:
		"!", ".", ",", "?":
			timer.start(punctuationTime)
		" ":
			timer.start(spaceTime)
		_:
			timer.start(letterTime)

func _on_letter_display_timer_timeout() -> void:
	displayLetter()

#display dialogue in image
func displayOrder(image_to_display: String):
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized #await x resize
		await resized #await y resize
		custom_minimum_size.y = size.y
	
	global_position.x -= size.x / 2
	global_position.y -= size.y + 25
	texture.texture = load(image_to_display)
