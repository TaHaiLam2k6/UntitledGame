extends Node
signal death_enemy(enemy: Character)
signal orphan_actor(orphan: Node2D)
signal spawn_enemy(enemy_data: EnemyData)
signal spawn_spark(spark_position: Vector2)
signal spawn_collectible(type: Collectible.Type, initial_state: Collectible.State, collectible_global_position: Vector2, collectible_direction: Vector2, collectible_height: float)
