extends Node2D

var parentGame

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.position.x = randi_range(424, 724)
	parentGame = get_parent()
	movement()
	
func movement():
	self.position.y += 25
	if self.position.y >= 536:
		self.queue_free()
		parentGame.spawnApple()
	await get_tree().create_timer(0.5).timeout
	movement()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		parentGame.hitApple(self)
