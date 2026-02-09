extends AnimatedSprite2D

var rng = RandomNumberGenerator.new()
@onready var initial_pos = position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

func playeffect():
	# TODO pick random +- 10 x and y
	show()
	play("default")
	offset = Vector2(rng.randi_range(-40, 40), rng.randi_range(-40, 40))
	await animation_looped
	stop()
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
