extends Control

@onready var area = $StaticBody2D/Area2D
@onready var spawnNode = $Marker2D
var minigameNode
var spawned = 0
var points = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	minigameNode = get_parent()
	spawnBeats()
	moveBeats()

func spawnBeats():
	var beat = load("res://objects/beat.tscn").instantiate()
	add_child(beat)
	beat.position = spawnNode.position
	if spawned != 15:
		var time = randf_range(1, 2)
		await get_tree().create_timer(time).timeout
		spawned += 1
		spawnBeats()

func moveBeats():
	var hits:Array = get_tree().get_nodes_in_group("collectable")
	if hits.is_empty():
		endGame()
		return
	for i in hits:
		if i.position.x <= -100:
			i.queue_free()
		else: i.position.x -= 20
	await get_tree().create_timer(0.30).timeout
	moveBeats()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("advance_dialogue"):
		var hits:Array = get_tree().get_nodes_in_group("collectable")
		if hits.is_empty():
			endGame()
			return
		var nearest = hits[0]
		for i in hits:
			if i.global_position.distance_to(area.global_position) < nearest.global_position.distance_to(area.global_position):
				nearest = i
		var deltaDistance = nearest.global_position.x - area.global_position.x
		if deltaDistance <= 3 and deltaDistance >= -20:
			points += 3
			nearest.queue_free()
		else:
			points += 1
			nearest.queue_free()

func endGame():
	if points <= 3:
		minigameNode.doneMinigame("fail")
	elif points >= 4 and points <= 10:
		minigameNode.doneMinigame("neutral")
	elif points >= 11 and points <= 34:
		minigameNode.doneMinigame("win")
	elif points >= 35:
		minigameNode.doneMinigame("perfect")
