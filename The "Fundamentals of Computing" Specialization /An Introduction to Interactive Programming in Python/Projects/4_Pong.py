# link for the project => http://www.codeskulptor.org/#user13_5j4zpODW9wG9alg_3.py

# Implementation of classic arcade game Pong

import simplegui
import random

# initialize globals - pos and vel encode vertical info for paddles
WIDTH = 600
HEIGHT = 400       
BALL_RADIUS = 20
PAD_WIDTH = 8
PAD_HEIGHT = 80
HALF_PAD_WIDTH = PAD_WIDTH / 2
HALF_PAD_HEIGHT = PAD_HEIGHT / 2
PADDLES_CONST_VELOCITY = 3
paddle1_pos = HEIGHT / 2
paddle2_pos = HEIGHT / 2
paddle1_vel = 0
paddle2_vel = 0
right = True
score1 = 0
score2 = 0

# helper function that spawns a ball by updating the 
# ball's position vector and velocity vector
# if right is True, the ball's velocity is upper right, else upper left
def ball_init(right):
    global ball_pos, ball_vel # these are vectors stored as lists
    ball_pos = [WIDTH / 2, HEIGHT / 2]
    ball_vel = [random.randrange(120,240) / 100, -random.randrange(60,240)  / 100]

    if not right:
       ball_vel[0] = - ball_vel[0] 
        
        


# define event handlers

def new_game():
    global paddle1_pos, paddle2_pos, paddle1_vel, paddle2_vel  # these are floats
    global score1, score2  # these are ints
    score1 = 0
    score2 = 0
    ball_init(True)

# This will check if the Paddles goes out of the boards    
def checkPaddlesBoards(pos):
        
    if pos + HALF_PAD_HEIGHT > HEIGHT:
        pos = HEIGHT - HALF_PAD_HEIGHT
        
    elif pos - HALF_PAD_HEIGHT < 0:
        pos = HALF_PAD_HEIGHT
    return pos
       
# Update the Paddles positions    
def updatePaddles():
    global paddle1_pos, paddle2_pos
    
    paddle1_pos += paddle1_vel
    paddle2_pos += paddle2_vel 
    
    paddle1_pos = checkPaddlesBoards(paddle1_pos)
    paddle2_pos = checkPaddlesBoards(paddle2_pos)

# Check if the Ball hits the gutter
def checkBallBoards():
    global ball_pos, ball_vel, right,score2,score1
    
    left_wall  = ball_pos[0] <= BALL_RADIUS + PAD_WIDTH
    right_wall = ball_pos[0] >= (WIDTH - PAD_WIDTH) - 1 - BALL_RADIUS
    up_wall    = ball_pos[1] <= BALL_RADIUS
    down_wall  = ball_pos[1] >= HEIGHT - 1 - BALL_RADIUS
    hph = HALF_PAD_HEIGHT
    p1 = paddle1_pos
    p2 = paddle2_pos
    
    # Ball hit the left wall
    if left_wall:
        
        hit_paddle1 = ball_pos[1] >= p1 - hph and ball_pos[1] <= p1 + hph
        #Hit the paddle so lets increment the velocity by 10%
        if hit_paddle1:
            ball_vel[0] = - (ball_vel[0] + 0.10 * ball_vel[0])
        # Hits the Gutter so player 2 receives +1 points.
        else:
            score2 += 1
            right = True
            ball_init(right)
            
     # Ball hit the right wall       
    elif right_wall:    
        
        hit_paddle2 = ball_pos[1] >= p2 - hph and ball_pos[1] <= p2 + hph
        #Hit the paddle so lets increment the velocity by 10%
        if hit_paddle2:
            ball_vel[0] = - (ball_vel[0] + 0.10 * ball_vel[0])
         # Hits the Gutter so player 2 receives +1 points.   
        else:
            score1 += 1
            right = False
            ball_init(right)
            
            
    
    if up_wall or down_wall:
        ball_vel[1] = -ball_vel[1]

  
def draw(c):
    global score1, score2, paddle1_pos, paddle2_pos, ball_pos, ball_vel
 
    # update paddle's vertical position, keep paddle on the screen
    updatePaddles()    

        
    # draw mid line and gutters
    c.draw_line([WIDTH / 2, 0],[WIDTH / 2, HEIGHT], 1, "White")
    c.draw_line([PAD_WIDTH, 0],[PAD_WIDTH, HEIGHT], 1, "White")
    c.draw_line([WIDTH - PAD_WIDTH, 0],[WIDTH - PAD_WIDTH, HEIGHT], 1, "White")
    
    # draw paddles
    paddle1_y1 = paddle1_pos - HALF_PAD_HEIGHT
    paddle1_y2 = paddle1_pos + HALF_PAD_HEIGHT
    paddle2_y1 = paddle2_pos - HALF_PAD_HEIGHT
    paddle2_y2 = paddle2_pos + HALF_PAD_HEIGHT
    
    c.draw_line([0,paddle1_y1], [0,paddle1_y2],PAD_WIDTH * 2, "White")
    c.draw_line([WIDTH,paddle2_y1], [WIDTH,paddle2_y2],PAD_WIDTH * 2, "White")
    
    # update ball
    
    ball_pos[0] = ball_pos[0] + ball_vel[0]
    ball_pos[1] = ball_pos[1] + ball_vel[1]
    
    checkBallBoards()
 
        
    # draw ball and scores
    c.draw_circle(ball_pos,BALL_RADIUS,2,"White","White")
    letter_size = 48
    c.draw_text(str(score1),[(WIDTH - letter_size) // 4,HEIGHT / 5],letter_size,"White")
    c.draw_text(str(score2),[WIDTH / 2 + WIDTH / 4,HEIGHT / 5],letter_size,"White")
    
        
def keydown(key):
    global paddle1_vel, paddle2_vel
    
    if key == simplegui.KEY_MAP["s"]:
        paddle1_vel += PADDLES_CONST_VELOCITY
    
    elif key == simplegui.KEY_MAP["w"]:
        paddle1_vel -= PADDLES_CONST_VELOCITY
        
    if key == simplegui.KEY_MAP["down"]:
        paddle2_vel += PADDLES_CONST_VELOCITY
        
    elif key == simplegui.KEY_MAP["up"]:
        paddle2_vel -= PADDLES_CONST_VELOCITY
    
        
   
def keyup(key):
    global paddle1_vel, paddle2_vel
    
    if key == simplegui.KEY_MAP["s"] or key == simplegui.KEY_MAP["w"]:
        paddle1_vel = 0
        
    elif key == simplegui.KEY_MAP["down"] or key == simplegui.KEY_MAP["up"]:
        paddle2_vel = 0
    
    
def restart():
    new_game()


# create frame
frame = simplegui.create_frame("Pong", WIDTH, HEIGHT)
frame.add_button("Restart",restart,100)
frame.set_draw_handler(draw)
frame.set_keydown_handler(keydown)
frame.set_keyup_handler(keyup)

new_game()

# start frame
frame.start()
