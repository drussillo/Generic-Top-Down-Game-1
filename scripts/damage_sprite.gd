extends AnimatedSprite2D

@onready var initial_pos = position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

func playeffect():
	# TODO pick random +- 10 x and y
	show()
	await animation_looped
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
