extends Node2D
const PREFAP_MAP := {
	Collectible.Type.FOOD: preload("res://scenes/props/food.tscn")
}
const SPARK_PREFAB := preload("res://scenes/props/spark.tscn")
const ENEMY_MAP := {
	Character.Type.PUNK: preload("res://scenes/Character/basic_enemy.tscn"),
	Character.Type.BOUNCER: preload("res://scenes/Character/igor_boss.tscn")
}
@export var player : Player
func _init() -> void:
	EntityManager.orphan_actor.connect(on_orphan_actor.bind())
	EntityManager.spawn_collectible.connect(on_spawn_collectible.bind())
	EntityManager.spawn_enemy.connect(on_spawn_enemy.bind())
	EntityManager.spawn_spark.connect(on_spawn_spark.bind())
	DamageManager.player_revive.connect(on_player_revive.bind())
func on_spawn_collectible(type: Collectible.Type, initial_state: Collectible.State, collectible_global_position: Vector2, collectible_direction: Vector2, initial_height: float) -> void:
	var collectible: Collectible = PREFAP_MAP[type].instantiate()
	collectible.state = initial_state
	collectible.height = initial_height
	collectible.global_position = collectible_global_position
	collectible.direction = collectible_direction
	call_deferred("add_child", collectible)
func on_spawn_enemy(enemy_data: EnemyData) -> void:
	var enemy :Character= ENEMY_MAP[enemy_data.type].instantiate()
	enemy.global_position = enemy_data.global_position
	enemy.player = player
	enemy.height = enemy_data.height
	enemy.state = enemy_data.state
	add_child(enemy)
func on_spawn_spark(spark_position: Vector2) -> void:
	var spark_instance := SPARK_PREFAB.instantiate()
	spark_instance.position = spark_position
	add_child(spark_instance)
func on_orphan_actor(orphan: Node2D) -> void:
	orphan.reparent(self)
func on_player_revive() -> void:
	for child in get_children():
		if child is Character:
			var character : Character = child as Character
			if character.type != Character.Type.PLAYER:
				character.on_receive_damage(0,Vector2.ZERO,DamageReceiver.HitType.KNOCKDOWN)
