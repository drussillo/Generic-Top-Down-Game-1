extends CharacterBody2D


var speed = 8000
var range = 60
var direction = Vector2(0, 0)
var HP = 50
var dead = false

@onready var navagent = $NavigationAgent2D

func _ready() -> void:
	position = [Vector2(670, -92), 
				Vector2(-140, 670), 
				Vector2(1440, 1170), 
				Vector2(2000, 280)].pick_random()
	#position = Vector2(1600, 260) #debug pos


func damage(amount: int) -> void:
	HP -= amount;
	if HP < 1:
		dead = true


func _play():
	if navagent.distance_to_target() < range or dead:
		velocity *= 0
		
func _animate():
	if !dead:
		$EnemyPawnSprite.flip_h = direction.x < 0
	if velocity.x != 0 or velocity.y != 0:
		$EnemyPawnSprite.play("run")
	elif navagent.distance_to_target() < range and !dead:
		$EnemyPawnSprite.play("attack")
	elif dead:
		$EnemyPawnSprite.play("dead")
	else:
		$EnemyPawnSprite.play("idle")
		
func _set_z_index():
	var player_pos = get_node("../Player").global_position
	# TODO refactor maybe?
	if player_pos.y < position.y:
		z_index = 1
	else:
		z_index = -1
		
func _set_direction():
	navagent.target_position = get_node("../Player").global_position
	var next_path_pos = navagent.get_next_path_position()
	direction = global_position.direction_to(next_path_pos)
	

func _physics_process(delta: float) -> void:
	_set_z_index()
	_set_direction()
	velocity = direction * speed * delta
	_play()
	_animate()
	move_and_slide()
