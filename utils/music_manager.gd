class_name MusicManager
extends Node
enum Music {INTRO, MENU, STAGE1}
@onready var music_stream_player: AudioStreamPlayer = $MusicStreamPlayer
var autoplayed_music: AudioStream = null
const MUSIC_MAP:Dictionary={
	Music.INTRO:preload("res://assets/intro.mp3"),
	Music.MENU:preload("res://assets/menu.mp3"),
	Music.STAGE1:preload("res://assets/stage-01.mp3"),
}
func _ready() -> void:
	if autoplayed_music != null:
		music_stream_player.stream = autoplayed_music
		music_stream_player.play()
func play(music: Music) -> void:
	if music_stream_player.is_node_ready():
		music_stream_player.stream = MUSIC_MAP[music]
		music_stream_player.play()
	else:
		autoplayed_music = MUSIC_MAP[music]
