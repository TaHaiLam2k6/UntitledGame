class_name MainMenu
extends Control
const OPTIONS_SCREEN_PREFAB := preload("res://scenes/ui/options_screen.tscn")
var options_screen:OptionsScreen = null
@export var music:MusicManager.Music
func has_network_connection() -> bool:
	var tcp = StreamPeerTCP.new()
	var err = tcp.connect_to_host("8.8.8.8", 53)
	if err == OK:
		return true
	return false
func _on_single_pressed() -> void:
	if has_network_connection():
		get_tree().change_scene_to_file("res://world.tscn")
func _on_options_pressed() -> void:
	if options_screen == null:
		options_screen = OPTIONS_SCREEN_PREFAB.instantiate()
		add_child(options_screen)
		options_screen.exit.connect(home)
func home() -> void:
	if options_screen:
		options_screen.queue_free()
		options_screen = null
func _ready() -> void:
	MusicPlayer.play(music)
