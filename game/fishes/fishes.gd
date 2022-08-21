extends KinematicBody2D

export (Resource) var scriptableObject = null
enum STATE {SWIMMING, BITING, FISHED, FUGITIVE, DEATH}
var actual_state = STATE.SWIMMING
var movement = Vector2.ZERO
const speed =  8
var speedDirectation = speed
var randomGenerator = RandomNumberGenerator.new()
var random = 1
var is_moving: bool = false
var initialPosition = 0
onready var animation = $AnimationPlayer

func _ready():
	pass
	
func _physics_process(delta):
	pass
	
func swinManager():
	animation.play("swim")
#	initialPosition = position.x
#	if !is_moving:
#		scale.x = 1
#		random = randomGenerator.randi_range(1,3)
#		movement.x = random * speed
#		is_moving = true
#		print(random)
#
#	elif position.x >= initialPosition + (random * speed):	
#		scale.x = -1
#		is_moving = false
#
#	movement = move_and_slide(movement, Vector2.UP)
	print(initialPosition)
	
func biteManager():
	pass
	
func runAwayManager():
	pass
	
func fishedManager():
	pass

func moveSomeDistance(distance: Vector2):
	move_and_slide(distance, Vector2.UP)

