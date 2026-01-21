extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _ready() -> void:
	#position = [Vector2(670, -92), 
	#			Vector2(-140, 670), 
	#			Vector2(1440, 1170), 
	#			Vector2(2000, 286)].pick_random()
	position = Vector2(1800, 260)
	get_node("EnemyPawnSprite").animation = "idle"


func _physics_process(delta: float) -> void:

	move_and_slide()
