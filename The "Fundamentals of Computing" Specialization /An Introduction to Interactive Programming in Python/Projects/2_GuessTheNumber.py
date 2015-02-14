# link for the project => http://www.codeskulptor.org/#user11_AYrx4nBms6nMjeY_0.py

# template for "Guess the number" mini-project
# input will come from buttons and an input field
# all output for the game will be printed in the console


import simplegui
import random
import math

# initialize global variables used in your code
# Max attempt is calculated using this expression:
# Max attempt from [0 to x] = log(x) / log (2)
# By default, the game starts with a range from [0,100)

low_range = 0
high_range = 0
max_attempts = 0


# define event handlers for control panel

def get_number_of_attempts(low,high):
    return math.ceil((math.log(high - low + 1) / math.log(2)))

def range100():
    # button that changes range to range [0,100) and restarts   
    global high_range, low_range
    global max_attempts, generated_number
    high_range = 100
    low_range  = 0
    max_attempts = get_number_of_attempts(0,100)
    generated_number = random.randrange(low_range, high_range)
    print "Number from [0,100) generated!"
    print "Remember that you got up to", max_attempts, "attempts to guess the number"
    
    
def range1000():
    # button that changes range to range [0,1000) and restarts
    global high_range, low_range 
    global max_attempts, generated_number
    high_range = 1000
    low_range  = 0
    max_attempts = get_number_of_attempts(0,1000)
    generated_number = random.randrange(low_range, high_range)
    print "Number from [0,1000) generated!"
    print "Remember that you got up to", max_attempts, "attempts to guess the number"
    
def get_input(guess):
    # main game logic goes here
    global max_attempts
    
    max_attempts -= 1
    
    #Convert the string user input to an integer
    int_guess = int(guess) 
        
    if(max_attempts <= 0):
        print "You lost!!!" 
        print "Sorry :( but you exceeded the number of possible attempts!"
        print "Game Initialized!"
        init() 
        
    elif(int_guess == generated_number):
        print "You are correct :D", guess, "is the correct number!"
        init()
        
    elif(int_guess > generated_number):
        print "The number is Lower than",int_guess
        print "You still have",max_attempts,"attempts."
    
    else:
        print "The number is Higher than",int_guess
        print "You still have",max_attempts,"attempts."
        
    

        
def init():
    # Use to initilization of the game.
    # By default the game starts with a range [0, 100)
    global user_attempts
    print "Lets Generate a new game"
    user_attempts = 0
    # Lets begin with a game equal to the last one played
    if(high_range <= 100):
        range100()
        
    else:
        range1000()
    
# Game initialization    
init()    

# create frame
frame = simplegui.create_frame("Guess the number",200,200)

# register event handlers for control elements
frame.add_button("Range: 0 - 100",range100,200)
frame.add_button("Range: 0 - 1000",range1000,200)
frame.add_input("Enter a guess",get_input,200)


# start frame
frame.start()

# always remember to check your completed program against the grading rubric

