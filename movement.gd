extends Node2D
# Made By Nieo
# class member variables go here
const  initballspeed= 100
var rightpadcoll 
var leftpadcoll 
export var speed=200
var balldiriction =Vector2(1.0,0)
var ballspeed= initballspeed
var screen 
var padsize
var rightscore = 0
var leftscore = 0
func _ready():
	screen=get_viewport_rect().size
	padsize=$right_player.get_texture().get_size()
	set_process(true)
	set_process_input(false)
func _input(event):
	if event.is_action("ui_up")==true:
		$right_player.position.y-=get_process_delta_time()*speed
	if event.is_action("ui_down")==true:
		$right_player.position.y+=get_process_delta_time()*speed
	if event.is_action("left_up")==true:
		$left_player.position.y-=get_process_delta_time()*speed
	if event.is_action("left_down")==true:
		$left_player.position.y+=get_process_delta_time()*speed
	$right_player.position.y=clamp($right_player.position.y,0,screen.y)
	$left_player.position.y=clamp($left_player.position.y,0,screen.y)

func _process(delta):
	rightpadcoll = Rect2($right_player.position-padsize*0.5 , padsize)
	leftpadcoll = Rect2($left_player.position-padsize*0.5 , padsize)
	if Input.is_action_pressed("ui_up")==true:
		$right_player.position.y-=delta*speed
	if Input.is_action_pressed("ui_down")==true:
		$right_player.position.y+=delta*speed
	if Input.is_action_pressed("left_up")==true:
		$left_player.position.y-=delta*speed
	if Input.is_action_pressed("left_down")==true:
		$left_player.position.y+=delta*speed
	
	if($ball.position.y <0 or $ball.position.y >screen.y ):
		balldiriction.y*=-1
	if(rightpadcoll.has_point($ball.position) or leftpadcoll.has_point($ball.position)):
		balldiriction.x*=-1
		balldiriction.y = randf()*2-1
		if ballspeed < 250:
			ballspeed*=1.2
	if( $ball.position.x >screen.x ):
		leftscore+=1
		$leftscore.text=str(leftscore)
		resetgame()
	if($ball.position.x <0 ):
		rightscore+=1
		$rightscore.text= str(rightscore)
		resetgame()
	$ball.position += balldiriction* ballspeed* delta
	$right_player.position.y=clamp($right_player.position.y,0,screen.y)
	$left_player.position.y=clamp($left_player.position.y,0,screen.y)

func resetgame():
	$ball.position = screen/2
	ballspeed=initballspeed
	$right_player.position = Vector2(600,200)
	$left_player.position= Vector2(40,200)