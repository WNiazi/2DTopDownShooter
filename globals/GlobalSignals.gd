extends Node

var score = 0 

signal bullet_fired(bullet, position, direction) 
signal bullet_impacted(position, direction)




func instance_node (node, location, parent): 
	var node_instance = node.instance()
	parent.add_child (node_instance)
	node_instance.global_position =location 
	return node_instance
