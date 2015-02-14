{\rtf1\ansi\ansicpg1252\cocoartf1038\cocoasubrtf360
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\paperw11900\paperh16840\margl1440\margr1440\vieww9000\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\ql\qnatural\pardirnatural
{\field{\*\fldinst{HYPERLINK "http://www.codeskulptor.org/#user15_EbimRIFIXx_7.py"}}{\fldrslt 
\f0\fs24 \cf0 http://www.codeskulptor.org/#user15_EbimRIFIXx_7.py}}
\f0\fs24 \
\
\
# Mini-project #6 - Blackjack\
\
import simplegui\
import random\
\
# load card sprite - 949x392 - source: jfitz.com\
CARD_SIZE = (73, 98)\
CARD_CENTER = (36.5, 49)\
card_images = simplegui.load_image("http://commondatastorage.googleapis.com/codeskulptor-assets/cards.jfitz.png")\
\
CARD_BACK_SIZE = (71, 96)\
CARD_BACK_CENTER = (35.5, 48)\
card_back = simplegui.load_image("http://commondatastorage.googleapis.com/codeskulptor-assets/card_back.png")    \
\
# initialize some useful global variables\
in_play = False\
outcome = "New Deal ?"\
score = 0\
msn = ""\
\
# define globals for cards\
SUITS = ('C', 'S', 'H', 'D')\
RANKS = ('A', '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K')\
VALUES = \{'A':1, '2':2, '3':3, '4':4, '5':5, '6':6, '7':7, '8':8, '9':9, 'T':10, 'J':10, 'Q':10, 'K':10\}\
\
\
# define card class\
class Card:\
    def __init__(self, suit, rank):\
        if (suit in SUITS) and (rank in RANKS):\
            self.suit = suit\
            self.rank = rank\
        else:\
            self.suit = None\
            self.rank = None\
            print "Invalid card: ", suit, rank\
\
    def __str__(self):\
        return self.suit + self.rank\
\
    def get_suit(self):\
        return self.suit\
\
    def get_rank(self):\
        return self.rank\
\
    def draw(self, canvas, pos):\
        card_loc = (CARD_CENTER[0] + CARD_SIZE[0] * RANKS.index(self.rank), \
                    CARD_CENTER[1] + CARD_SIZE[1] * SUITS.index(self.suit))\
        canvas.draw_image(card_images, card_loc, CARD_SIZE, [pos[0] + CARD_CENTER[0], pos[1] + CARD_CENTER[1]], CARD_SIZE)\
        \
# define hand class\
class Hand:\
    def __init__(self):\
        # create Hand object\
        self.hand = []\
\
    def __str__(self):\
        # return a string representation of a hand\
        string = ""\
        for card in self.hand:\
            string += str(card)\
            string += " "\
        \
        return string\
        \
    def add_card(self, card):\
        # add a card object to a hand\
        self.hand.append(card)\
\
    def get_value(self):\
        # count aces as 1, if the hand has an ace, then add 10 to hand value if it doesn't bust\
        # compute the value of the hand, see Blackjack video\
        value = 0\
        aces = False\
        for card in self.hand:\
            rank = card.get_rank()\
            value += VALUES[rank]\
            if rank == 'A':\
                aces = True\
        \
        if aces and value + 10 <= 21:\
            value += 10\
            \
        return value\
            \
        \
    def draw(self, canvas, pos):\
        # draw a hand on the canvas, use the draw method for cards\
        cardp = [pos[0],pos[1]]\
        for card in self.hand:\
            card.draw(canvas,cardp)\
            cardp[0] += 100\
        \
        \
        \
#####################################################\
# Student should insert code for Deck class here\
class Deck:\
    def __init__(self):\
        # create a Deck object\
        SUITS = ('C', 'S', 'H', 'D')\
        RANKS = ('A', '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K')\
        \
        self.deck = []\
        for s in SUITS:\
            for r in RANKS:\
                self.deck.append(Card(s,r))\
                \
    def shuffle(self):\
        # add cards back to deck and shuffle\
        # use random.shuffle() to shuffle the deck\
        random.shuffle(self.deck)\
        \
    def deal_card(self):\
        # deal a card object from the deck\
        return self.deck.pop()\
    \
    def __str__(self):\
        # return a string representing the deck\
        string = ""\
        for cards in self.deck:\
            string += str(cards)\
            string += " "\
            \
        return string \
\
\
deck = Deck()\
player = Hand()\
dealer = Hand()\
\
#define event handlers for buttons\
def deal():\
    global outcome, in_play, deck,player,dealer,score,msn\
    \
    if in_play:\
        score -= 1\
   \
    # your code goes here\
    deck = Deck()\
    player = Hand()\
    dealer = Hand()\
    deck.shuffle()\
    player.add_card(deck.deal_card())\
    dealer.add_card(deck.deal_card())\
    player.add_card(deck.deal_card())\
    dealer.add_card(deck.deal_card())\
    outcome = "Hit or Stand ?"\
    msn = ""\
    in_play = True\
\
def hit():\
    # if the hand is in play, hit the player\
    global in_play, player, score, outcome, msn\
    \
    if in_play:\
        player.add_card(deck.deal_card())\
        \
        if player.get_value() > 21:\
            msn = "You have busted"\
            outcome = "New Deal ?"\
            in_play = False\
            score -= 1\
    \
    # if busted, assign a message to outcome, update in_play and score\
       \
def stand():\
    global in_play,dealer,player,outcome, score,msn\
    # if hand is in play, repeatedly hit dealer until his hand has value 17 or more\
    \
    if in_play and msn == "":\
\
         while dealer.get_value() < 17:    \
            dealer.add_card(deck.deal_card())\
            \
            \
         in_play = False\
         \
         if dealer.get_value() > 21:\
            msn = "Dealer got Busted! You Win"\
            score += 1\
         elif dealer.get_value() >= player.get_value():\
             msn = "Dealer Wins!"\
             score -= 1\
         else:\
             msn = "Player Wins!"\
             score += 1\
         outcome = "New Deal ?"\
             \
    # assign a message to outcome, update in_play and score\
\
# draw handler    \
def draw(canvas):\
    # test to make sure that card.draw works, replace with your code below\
    global player, dealer, outcome,score, msn, in_play\
   \
    dealer.draw(canvas, [50, 150])\
    player.draw(canvas, [50, 450])\
    \
    if in_play:\
        canvas.draw_image(card_back, CARD_BACK_CENTER, CARD_BACK_SIZE, [50 + CARD_CENTER[0], 150 + CARD_CENTER[1]], CARD_BACK_SIZE)\
   \
        \
    canvas.draw_text("Dealer", (50, 130), 26, "Black")\
    canvas.draw_text(msn, (200, 130), 26, "Black")\
    canvas.draw_text("Player", (50, 400), 26, "Black")\
    canvas.draw_text("Score : " + str(score), (420, 46), 26, "White")\
    canvas.draw_text("Blackjack", (20, 46), 46, "White")\
    canvas.draw_text(outcome, (200, 400), 26, "Black")\
\
\
# initialization frame\
frame = simplegui.create_frame("Blackjack", 600, 600)\
frame.set_canvas_background("Green")\
\
#create buttons and canvas callback\
frame.add_button("Deal", deal, 200)\
frame.add_button("Hit",  hit, 200)\
frame.add_button("Stand", stand, 200)\
frame.set_draw_handler(draw)\
\
\
# get things rolling\
frame.start()\
\
\
# remember to review the gradic rubric}