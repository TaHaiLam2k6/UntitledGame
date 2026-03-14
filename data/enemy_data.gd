class_name EnemyData
extends Resource
const DROP_HEIGHT := 50
@export var height: int
@export var type: Character.Type
@export var global_position: Vector2
@export var state: Character.State
func _init(character_type: Character.Type = Character.Type.PUNK, position: Vector2 = Vector2.ZERO) -> void:
	type = character_type
	if position.y < 0:
		height = DROP_HEIGHT
		global_position = position + Vector2.DOWN * DROP_HEIGHT
		state = Character.State.DROP
	else:
		global_position = position
		state = Character.State.IDLE
