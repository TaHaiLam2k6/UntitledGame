class_name Stage
extends Node2D
@onready var containers : Node2D = $Containers
@onready var checkpoints: Node2D = $Checkpoints
@export var music:MusicManager.Music
func _ready() -> void:
	for container : Node2D in containers.get_children():
		EntityManager.orphan_actor.emit(container)
	for checkpoint : Checkpoint in checkpoints.get_children():
		checkpoint.create_enemy_data()
	MusicPlayer.play(music)
