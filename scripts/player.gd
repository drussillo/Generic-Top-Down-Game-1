extends CharacterBody2D


var speed = 15000
var diaspeed = sqrt(pow(speed, 2) / 2)
var HP = 100
var current_anim = "idle"

var guarding = false
var attacking = false
var right = true  # false -> facing left


func hit(damage: int):
	HP -= damage
	print("Player Hit! ", HP)

func _input(ev):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
		
	if attacking: 
		return
	
	velocity *= 0

	if !guarding:
		if !Input.is_anything_pressed():
			current_anim = "idle"

		if Input.is_action_pressed("Up"): 
			velocity.y -= 1
		if Input.is_action_pressed("Down"): 
			velocity.y += 1
		if Input.is_action_pressed("Left"): 
			right = false
			velocity.x -= 1
		if Input.is_action_pressed("Right"): 
			right = true
			velocity.x += 1
		
		if velocity.x != 0 and velocity.y != 0: 
			velocity *= diaspeed
			current_anim = "run"
		elif velocity.x != 0 or velocity.y != 0: 
			velocity *= speed
			current_anim = "run"

	if Input.is_action_pressed("Guard"):
		current_anim = "guard"
		guarding = true
	if Input.is_action_just_released("Guard"):
		guarding = false
		
	if Input.is_action_just_pressed("Attack"):
		current_anim = ["attack1", "attack2"].pick_random()
		attacking = true
		


func _animate():
	$Sprite.flip_h = !right
	
	if $Sprite.animation != current_anim:
		$Sprite.play(current_anim)
		if attacking:
			await $Sprite.animation_finished
			attacking = false
			guarding = false
			current_anim = "idle"


func _physics_process(delta: float) -> void:
	_input(0)
	_animate()
	
	velocity *= delta
	move_and_slide()
