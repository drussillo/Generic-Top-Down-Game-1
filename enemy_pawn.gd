extends CharacterBody2D


const speed = 8000

@onready var navagent = $NavigationAgent2D

func _ready() -> void:
	position = [Vector2(670, -92), 
				Vector2(-140, 670), 
				Vector2(1440, 1170), 
				Vector2(2000, 280)].pick_random()
	#position = Vector2(1600, 260) #debug pos


func _play():
	if velocity == Vector2(0, 0):
		$EnemyPawnSprite.play("attack")
		await $EnemyPawnSprite.animation_finished
		get_node("../Player").hit(10)
	else:
		$EnemyPawnSprite.play("run")
		
func _set_z_index():
	var player_pos = get_node("../Player").global_position
	if player_pos.y < position.y:
		z_index = 1
	else:
		z_index = -1

func _physics_process(delta: float) -> void:
	_set_z_index()
	
	navagent.target_position = get_node("../Player").global_position
	var next_path_pos = navagent.get_next_path_position()
	var direction = global_position.direction_to(next_path_pos)
	velocity = direction * speed * delta
	
	$EnemyPawnSprite.flip_h = direction.x < 0
	
	if navagent.distance_to_target() < 60:
		velocity = Vector2(0, 0)
	
	_play()	
	move_and_slide()
