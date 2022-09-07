extends Sprite

export (int) var swim_velocity = 1
export (int) var time_to_wait = 1

var bait_is_near:bool = false
var is_biting:bool = false
var is_swimming:bool = false
var timer_called:bool = false
var needs_new_target_position: bool =  true
 
enum ACTION {SWIM_AROUND, TURN_AND_SWIM, STOP_AND_WAIT, FOLLOW_BAIT, BITE_THE_BAIT, RUNAWAY}
var current_action = ACTION.SWIM_AROUND
var next_action = ACTION.SWIM_AROUND
var target_position: Vector2 = Vector2.ZERO
var direction_facing:Vector2 = Vector2.ZERO
onready var wait_time = $Timer

func _ready():
	wait_time.set_one_shot(true) 
func _physics_process(delta):
	
	# Manage actions
	if current_action == ACTION.SWIM_AROUND:
		
		# If timer is called dont process this action
		if timer_called:
			return

		if needs_new_target_position:
			print("Current position: ", self.position)
			target_position =  set_random_target_position()
			needs_new_target_position = false
		
		# Swin to target position			
		move_towards_position(target_position, delta)
		
		# Wait random seconds
		if self.position.distance_to(target_position) < 2:
			print("STOP")
			needs_new_target_position = true
			current_action = ACTION.STOP_AND_WAIT
			next_action = ACTION.SWIM_AROUND
			print(current_action)
			
			
	elif current_action == ACTION.TURN_AND_SWIM:
		
		# If timer is called dont process this action
		if timer_called:
			return
			
		if needs_new_target_position:	
			print("Current position: ", self.position)
			target_position = set_turn_target_position()
			needs_new_target_position = false
		
		move_towards_position(target_position, delta)
		
		# Wait random seconds
		if self.position.distance_to(target_position) < 2:
			print("STOP")
			needs_new_target_position = true
			current_action = ACTION.STOP_AND_WAIT
			next_action = ACTION.SWIM_AROUND
			print(current_action)

	elif current_action == ACTION.STOP_AND_WAIT:
		print("WAIT ACTION")
		if !timer_called:
			start_timer(time_to_wait)
	elif current_action == ACTION.FOLLOW_BAIT:
		# print("FOLLOW_BAIT")
		pass
	elif current_action == ACTION.BITE_THE_BAIT:
		pass
	elif current_action == ACTION.RUNAWAY:
		pass



# -------------------------------------- PRIVATE FUNCTIONS --------------------------------------

# Set target position
	# Set random direction left or right
	# Set random distance x
	# Set random distance up or down
	# Set random distance y
func set_random_target_position() -> Vector2:
	var direction = [-1,1]
	
	# Random class
	var rng = RandomNumberGenerator.new()
	
	# set x
	rng.randomize()
	var x_distance = rng.randi_range(0, 32)
	var x_direction = direction[rng.randi_range(0, 1)]
	
	# Change sprite direction -> refactor later
	if x_direction == 1:
		self.scale.x = -1
	else:
		self.scale.x = 1
	
	# set y
	rng.randomize()
	var y_distance = rng.randi_range(0, 16)
	var y_direction = direction[rng.randi_range(0, 1)]
	
	# Set target vector
	# var random_target_position =  Vector2(self.position.x + x_direction*x_distance, self.position.y)
	var random_target_position =  Vector2(self.position.x + x_direction*x_distance, self.position.y + y_direction*y_distance)
	print("Target position: ", random_target_position)
	return random_target_position

# Set target position turn around
	# Move position to target vector
func move_towards_position(target_position_vector: Vector2, delta: float):
	self.position += self.position.direction_to(target_position_vector) * delta * swim_velocity


# Swin to target position	
	# Move position to target vector
func set_turn_target_position() -> Vector2:
	var direction = [-1,1]
	
	# set x	
	var x_distance = 32
	var x_direction
	
	if self.scale.x == -1:
		self.scale.x = 1
		
		x_direction = direction[0]
	else:
		self.scale.x = -1
		x_direction = direction[1]

	var random_target_position =  Vector2(self.position.x + x_direction*x_distance, self.position.y)
	# var random_target_position =  Vector2(self.position.x + x_direction*x_distance, self.position.y + y_direction*y_distance)
	print("Target TURN position: ", random_target_position)
	return random_target_position
	
func start_timer(second: int):
	print("Start timer")
	timer_called = true
	wait_time.start(second)
	
	

# -------------------------------------- NODE'S SIGNALS  --------------------------------------

func _on_MouthCollision_area_entered(area: Area2D):
	if area.is_in_group("bait"):
		current_action =  ACTION.FOLLOW_BAIT
		
	elif area.is_in_group("edge"):
		needs_new_target_position = true
		current_action = ACTION.TURN_AND_SWIM
	
	
	print("group: ", area.get_groups())


func _on_Timer_timeout():
	print("Time out")
	current_action = next_action
	timer_called = false
