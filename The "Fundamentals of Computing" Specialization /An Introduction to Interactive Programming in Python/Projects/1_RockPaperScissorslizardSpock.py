#assigment link => http://www.codeskulptor.org/#user10_YsEGHoxJYJ_0.py

import random

# Rock-paper-scissors-lizard-Spock template


# The key idea of this program is to equate the strings
# "rock", "paper", "scissors", "lizard", "Spock" to numbers
# as follows:
#
# 0 - rock
# 1 - Spock
# 2 - paper
# 3 - lizard
# 4 - scissors

# helper functions

def number_to_name(number):
    if   number == 0: return "rock"
    elif number == 1: return "Spock"
    elif number == 2: return "paper"
    elif number == 3: return "lizard"
    elif number == 4: return "scissors"
    else: return "Invalid Option"
 
    # fill in your code below
    
    # convert number to a name using if/elif/else
    # don't forget to return the result!

    
def name_to_number(name):
    if   name == 'rock':     return 0
    elif name == 'Spock':    return 1
    elif name == 'paper':    return 2
    elif name == 'lizard':   return 3
    elif name == 'scissors': return 4
    else: return "Invalid Option"
    
    
    # fill in your code below

    # convert name to number using if/elif/else
    # don't forget to return the result!


def rpsls(name): 
    # fill in your code below
    totalOptions = 5 # The total of avaible options

    # convert name to player_number using name_to_number
    player_number = name_to_number(name)
   
    # compute random guess for comp_number using random.randrange()
    computer_guess = random.randrange(0,totalOptions)
   
    # compute difference of player_number and comp_number modulo five
    difference = (player_number - computer_guess) % totalOptions
    
    # use if/elif/else to determine winner
    if   difference == 0: winner = "Player and computer tie!\n"
    elif difference >  2: winner = "Computer wins!\n"
    else:                 winner = "Player wins!\n"
        

    # convert comp_number to name using number_to_name
    computer_guess_name = number_to_name(computer_guess)
    
    # print results
    print "Player chooses", name
    print "Computer chooses", computer_guess_name
    print winner

    
# test your code
rpsls("rock")
rpsls("Spock")
rpsls("paper")
rpsls("lizard")
rpsls("scissors")

# always remember to check your completed program against the grading rubric

