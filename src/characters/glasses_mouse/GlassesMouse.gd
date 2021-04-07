extends KinematicBody2D

const SPEED = 125.0
const ACCELERATION = 2.0

onready var fsm = FSM.new(self, $States, $States/Idle, false)
onready var particles = $Particles
onready var sunglasses = $Sunglasses

var velocity = Vector2.ZERO

func _process(delta):
	fsm.run_machine(delta)
