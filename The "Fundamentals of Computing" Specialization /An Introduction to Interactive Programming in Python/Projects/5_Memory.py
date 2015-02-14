{\rtf1\ansi\ansicpg1252\cocoartf1038\cocoasubrtf360
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\paperw11900\paperh16840\margl1440\margr1440\vieww9000\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\ql\qnatural\pardirnatural
{\field{\*\fldinst{HYPERLINK "http://www.codeskulptor.org/#user14_W6fCw96kkq_3.py"}}{\fldrslt 
\f0\fs24 \cf0 http://www.codeskulptor.org/#user14_W6fCw96kkq_3.py}}
\f0\fs24 \
\
\
# CodeSkulptor runs Python programs in your browser.\
# Click the upper left button to run this simple demo.\
\
# CodeSkulptor runs in Chrome 18+, Firefox 11+, and Safari 6+.\
# Some features may work in other browsers, but do not expect\
# full functionality.  It does NOT run in Internet Explorer.\
\
import simplegui\
\
message = "Welcome!"\
\
# Handler for mouse click\
def click():\
    global message\
    message = "Good job!"\
\
# Handler to draw on canvas\
def draw(canvas):\
    canvas.draw_text(message, [50,112], 48, "Red")\
\
# Create a frame and assign callbacks to event handlers\
frame = simplegui.create_frame("Home", 300, 200)\
frame.add_button("Click me", click)\
frame.set_draw_handler(draw)\
\
# Start the frame animation\
frame.start()\
}