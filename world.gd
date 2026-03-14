extends Node2D
var player: Node2D
@onready var camera := $Camera
var is_camera_locked := false
func _ready() -> void:
	StageManager.checkpoint_start.connect(on_checkpoint_start.bind())
	StageManager.checkpoint_complete.connect(on_checkpoint_complete.bind())
	$ActorsContainer.child_entered_tree.connect(_on_player_spawned)
func _on_player_spawned(node):
	if node.get_multiplayer_authority() == multiplayer.get_unique_id():
		player = node
func _process(_delta: float) -> void:
	if player and not is_camera_locked and player.position.x > camera.position.x:
		camera.position.x = player.position.x
func on_checkpoint_start() -> void:
	is_camera_locked = true
func on_checkpoint_complete() -> void:
	is_camera_locked = false
