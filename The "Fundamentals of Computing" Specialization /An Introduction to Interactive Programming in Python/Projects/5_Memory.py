#link for the project => http://www.codeskulptor.org/#user14_W6fCw96kkq_3.py

# implementation of card game - Memory

import simplegui
import random

card_deck = []
exposed = []
SIZE = 8
WIDHT = 800
HEIGH = 100
CARD_WIDTH = 50
CARD_HEIGH = 100
state = 0
last_card = 0
snd_last_card = 0
move = 0
status = 0

def create_deck(size):
    list = []
    for n in range(size):
        list.append(n)
        list.append(n)
        
    return list

# helper function to initialize globals
def init():
    global card_deck, exposed, move,state,last_card,snd_last_card 
    card_deck = create_deck(SIZE)
    random.shuffle(card_deck)
    exposed = [False for deck in card_deck]
    state = 0
    last_card = 0
    snd_last_card = 0
    move = 0
    status = 0

def is_in_range(pos):
    return pos[1] > 0 and pos[1] < HEIGH and pos[0] > 0 and pos[0] < WIDHT

def check_cards_state(x):
    global state,last_card,snd_last_card
    if state == 0:
       state = 1
       snd_last_card = x  
        
    elif state == 1:
          state = 2
          last_card = x
    else:
         
         if card_deck[snd_last_card] != card_deck[last_card]:
             exposed[snd_last_card] = False
             exposed[last_card] = False
         snd_last_card = x
         state = 1
    

# define event handlers
def mouseclick(pos):
    # add game state logic here
    global exposed,move, status
    
    x = pos[0] // CARD_WIDTH
    
    if is_in_range(pos) and not exposed[x]:
       exposed[x] = True
       check_cards_state(x)
       if status == 0:
          move = move + 1
          status = 1
       else:
          status = 0
          
       
       
    
    
                        
# cards are logically 50x100 pixels in size    
def draw(canvas):
    card_width = 50
    card_heigh = 100
    half_width = card_width // 2
    letter_size = 60
    adjust = (card_width - (letter_size // 2)) // 2
    x = 0
    y = (card_heigh + letter_size) // 2 - letter_size // 5
    pos = 0
    
    for card in card_deck:
        if  exposed[pos]:
            canvas.draw_text(str(card), (x + adjust, y), letter_size, "white")
        else:
            canvas.draw_line((x+half_width, 0), (x+half_width, card_heigh), card_width, "Green")
        pos = pos + 1
        x = x + card_width
        canvas.draw_line((x,0),(x,card_heigh),2,"red")
        
    label.set_text("Moves = "+str(move))
        

# create frame and add a button and labels
frame = simplegui.create_frame("Memory", WIDHT, HEIGH)
frame.add_button("Restart", init)
label = frame.add_label("Moves = 0")

# initialize global variables
init()

# register event handlers
frame.set_mouseclick_handler(mouseclick)
frame.set_draw_handler(draw)


# get things rolling
frame.start()
print str(move)
label.set_text("Moves = "+str(move))


# Always remember to review the grading rubric
