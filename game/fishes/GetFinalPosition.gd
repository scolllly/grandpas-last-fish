extends ActionLeaf

export (String) var initial_position_key
export (String) var distance_key
export (int) var distance = 0

func tick(actor, blackboard):
	var get_initial_position = blackboard.get("get_initial_position")
	print("valor: ", get_initial_position)
	if get_initial_position or get_initial_position == null:
		var initialPosition = actor.position.x
		blackboard.set(initial_position_key, initialPosition)
		blackboard.set(distance_key, distance)
		
	return SUCCESS
