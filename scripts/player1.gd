extends CharacterBody2D



var attacking = false
var guarding = false
var speed = 200
var diaspeed = sqrt(pow(speed, 2) / 2)


func _input(ev):
	if !attacking:
		if !guarding:
			if Input.is_action_pressed("Up"):
				velocity = Vector2(0, -speed)
				get_node("Sprite").animation = "run"
			if Input.is_action_pressed("Down"):
				get_node("Sprite").animation = "run"
				velocity = Vector2(0, speed)
			if Input.is_action_pressed("Left"):
				get_node("Sprite").animation = "run"
				get_node("Sprite").flip_h = true
				velocity = Vector2(-speed, 0)
			if Input.is_action_pressed("Right"):
				get_node("Sprite").animation = "run"
				get_node("Sprite").flip_h = false
				velocity = Vector2(speed, 0)
			if Input.is_action_pressed("Up") and Input.is_action_pressed("Right"):
				velocity = Vector2(diaspeed, -diaspeed)
				get_node("Sprite").animation = "run"
			if Input.is_action_pressed("Down") and Input.is_action_pressed("Right"):
				get_node("Sprite").animation = "run"
				velocity = Vector2(diaspeed, diaspeed)
			if Input.is_action_pressed("Up") and Input.is_action_pressed("Left"):
				velocity = Vector2(-diaspeed, -diaspeed)
				get_node("Sprite").animation = "run"
			if Input.is_action_pressed("Down") and Input.is_action_pressed("Left"):
				get_node("Sprite").animation = "run"
				velocity = Vector2(-diaspeed, diaspeed)
		else:
			velocity = Vector2(0, 0)

		if Input.is_action_pressed("Guard"):
			get_node("Sprite").animation = "guard"
			guarding = true
		if Input.is_action_just_released("Guard"):
			guarding = false
		
		if !Input.is_anything_pressed():
			get_node("Sprite").animation = "idle"
			velocity = Vector2(0, 0)
			
		if Input.is_action_just_pressed("Attack"):
			velocity = Vector2(0, 0)
			get_node("Sprite").animation = ["attack1", "attack2"].pick_random()
			attacking = true
			await get_node("Sprite").animation_finished
			attacking = false

	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()


func _play():
	if !get_node("Sprite").is_playing():
		get_node("Sprite").play("idle")
		

func _physics_process(delta: float) -> void:
	_input(0)
	_play()
	
	move_and_slide()
