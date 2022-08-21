extends ActionLeaf

export (String) var initial_position_key
export (String) var distance_key

func tick(actor, blackboard):
	blackboard.set("get_initial_position", false)
	var initialPosition = blackboard.get(initial_position_key)
	var distance =  blackboard.get(distance_key)	
	

	print(" Position: ", actor.position.x, " init + distance: ", initialPosition + distance )
	if actor.position.x <= initialPosition + distance:
		actor.animation.play("swim")
		actor.moveSomeDistance(Vector2(distance, 0))
		actor.scale.x = -actor.scale.x
		blackboard.set("get_initial_position", true)
		return SUCCESS
		
	return RUNNING
