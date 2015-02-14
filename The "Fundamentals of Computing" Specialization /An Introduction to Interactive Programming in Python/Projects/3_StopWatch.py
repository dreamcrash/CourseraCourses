#link for the project => http://www.codeskulptor.org/#user12_UivEwgCK5S_3.py

# template for "Stopwatch: The Game"

import simplegui
import math


# define global variables
interval = 100 # 0.1 seconds is 100 milliseconds
width = 300
height = 300
time = 0
status = "stop"
success_attempts = 0
total_attempts = 0
running  = False


# define helper function format that converts time
# in tenths of seconds into formatted string A:BC.D
def format(t):
    minutes = t // 600
    bc = str(round(t - minutes * 600))
    size = len(bc)

    if(size == 1):
        bc = "00" + bc
        size += 2
        
    elif(size == 2):
        bc = "0" + bc
        size += 1
        
    bc_string = bc[:size-1]
    d = bc[size-1]    
    
    return str (minutes) + ":" + bc_string + "." +d
    
# define event handlers for buttons; "Start", "Stop", "Reset"
def start():
    global status, running
    status = "start"
    running = True
    
def stop():
    global status, success_attempts, total_attempts, running
    status = "stop"
    if(running):
        total_attempts += 1
        if(time >= 10 and time % 10 == 0):
            success_attempts += 1
    running = False
    
def reset():
    global status, success_attempts, total_attempts, running
    status = "reset"
    success_attempts = 0
    total_attempts = 0
    running = False

# define event handler for timer with 0.1 sec interval
def tick():
    global time
    if(status == "start"):
        time += 1
    elif(status == "reset"):
        time = 0
 

# define draw handler
def draw (canvas):
    global time, success_attempts, total_attempts
    message = format (time)
    reflexes_string = str(success_attempts) + "/" + str (total_attempts)
    letter_size = 36
    letter_size_attempts = 18
    x = (width - letter_size) / 2
    y = height / 2
    canvas.draw_text(message,(x, y), letter_size, "Red")
    canvas.draw_text(reflexes_string, (width - 2 * letter_size_attempts, letter_size_attempts), letter_size_attempts, "White")
    
    
    
# create frame
frame = simplegui.create_frame("Stopwatch: The Game", width, height)

# register event handlers
timer = simplegui.create_timer(interval, tick)
frame.set_draw_handler(draw)
frame.add_button("Start",start,200)
frame.add_button("Stop",stop,200)
frame.add_button("Reset",reset,200)

# Start the frame animation
frame.start()

# start frame
frame.start()
timer.start()


# Please remember to review the grading rubric
