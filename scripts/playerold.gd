extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

var attacking = false
var guarding = false
var speed = 3

func _input(ev):
	if !attacking:
		if !guarding:
			if Input.is_action_pressed("Up"):
				position += Vector2(0, -speed)
				animation = "run"
			if Input.is_action_pressed("Down"):
				animation = "run"
				position += Vector2(0, speed)
			if Input.is_action_pressed("Left"):
				animation = "run"
				flip_h = true
				position += Vector2(-speed, 0)
			if Input.is_action_pressed("Right"):
				animation = "run"
				flip_h = false
				position += Vector2(speed, 0)
		else:
			if Input.is_action_pressed("Up"):
				position += Vector2(0, -1)
			if Input.is_action_pressed("Down"):
				position += Vector2(0, 1)
			if Input.is_action_pressed("Left"):
				position += Vector2(-1, 0)
			if Input.is_action_pressed("Right"):
				position += Vector2(1, 0)

			

		if Input.is_action_pressed("Guard"):
			animation = "guard"
			guarding = true
		if Input.is_action_just_released("Guard"):
			guarding = false
		
		if !Input.is_anything_pressed():
			animation = "idle"
			
		if Input.is_action_just_pressed("Attack"):
			animation = ["attack1", "attack2"].pick_random()
			attacking = true
			await animation_finished
			attacking = false

	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
		

func _play():
	if !is_playing():
		play("idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_input(0)
	_play()
