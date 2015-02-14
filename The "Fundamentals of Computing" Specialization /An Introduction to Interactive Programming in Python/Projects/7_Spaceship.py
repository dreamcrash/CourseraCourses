{\rtf1\ansi\ansicpg1252\cocoartf1038\cocoasubrtf360
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\paperw11900\paperh16840\margl1440\margr1440\vieww9000\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\ql\qnatural\pardirnatural
{\field{\*\fldinst{HYPERLINK "http://www.codeskulptor.org/#user16_EXFeR3uMjg_36.py"}}{\fldrslt 
\f0\fs24 \cf0 http://www.codeskulptor.org/#user16_EXFeR3uMjg_36.py}}
\f0\fs24 \
\
# program template for Spaceship\
import simplegui\
import math\
import random\
\
# globals for user interface\
WIDTH = 800\
HEIGHT = 600\
score = 0\
lives = 3\
time = 0.5\
CONST_ANGLE = 0.1\
CONST_VEL = 1\
FRICTION = 0.02\
ACELARATION = 0.25\
MISSEL_VEL = 5\
\
\
class ImageInfo:\
    def __init__(self, center, size, radius = 0, lifespan = None, animated = False):\
        self.center = center\
        self.size = size\
        self.radius = radius\
        if lifespan:\
            self.lifespan = lifespan\
        else:\
            self.lifespan = float('inf')\
        self.animated = animated\
\
    def get_center(self):\
        return self.center\
\
    def get_size(self):\
        return self.size\
\
    def get_radius(self):\
        return self.radius\
\
    def get_lifespan(self):\
        return self.lifespan\
\
    def get_animated(self):\
        return self.animated\
\
    \
# art assets created by Kim Lathrop, may be freely re-used in non-commercial projects, please credit Kim\
    \
# debris images - debris1_brown.png, debris2_brown.png, debris3_brown.png, debris4_brown.png\
#                 debris1_blue.png, debris2_blue.png, debris3_blue.png, debris4_blue.png, debris_blend.png\
debris_info = ImageInfo([320, 240], [640, 480])\
debris_image = simplegui.load_image("http://commondatastorage.googleapis.com/codeskulptor-assets/lathrop/debris2_blue.png")\
\
# nebula images - nebula_brown.png, nebula_blue.png\
nebula_info = ImageInfo([400, 300], [800, 600])\
nebula_image = simplegui.load_image("http://commondatastorage.googleapis.com/codeskulptor-assets/lathrop/nebula_blue.png")\
\
# splash image\
splash_info = ImageInfo([200, 150], [400, 300])\
splash_image = simplegui.load_image("http://commondatastorage.googleapis.com/codeskulptor-assets/lathrop/splash.png")\
\
# ship image\
ship_info = ImageInfo([45, 45], [90, 90], 35)\
ship_image = simplegui.load_image("http://commondatastorage.googleapis.com/codeskulptor-assets/lathrop/double_ship.png")\
\
# missile image - shot1.png, shot2.png, shot3.png\
missile_info = ImageInfo([5,5], [10, 10], 3, 50)\
missile_image = simplegui.load_image("http://commondatastorage.googleapis.com/codeskulptor-assets/lathrop/shot2.png")\
\
# asteroid images - asteroid_blue.png, asteroid_brown.png, asteroid_blend.png\
asteroid_info = ImageInfo([45, 45], [90, 90], 40)\
asteroid_image = simplegui.load_image("http://commondatastorage.googleapis.com/codeskulptor-assets/lathrop/asteroid_blue.png")\
\
# animated explosion - explosion_orange.png, explosion_blue.png, explosion_blue2.png, explosion_alpha.png\
explosion_info = ImageInfo([64, 64], [128, 128], 17, 24, True)\
explosion_image = simplegui.load_image("http://commondatastorage.googleapis.com/codeskulptor-assets/lathrop/explosion_alpha.png")\
\
# sound assets purchased from sounddogs.com, please do not redistribute\
soundtrack = simplegui.load_sound("http://commondatastorage.googleapis.com/codeskulptor-assets/sounddogs/soundtrack.mp3")\
missile_sound = simplegui.load_sound("http://commondatastorage.googleapis.com/codeskulptor-assets/sounddogs/missile.mp3")\
missile_sound.set_volume(.5)\
ship_thrust_sound = simplegui.load_sound("http://commondatastorage.googleapis.com/codeskulptor-assets/sounddogs/thrust.mp3")\
explosion_sound = simplegui.load_sound("http://commondatastorage.googleapis.com/codeskulptor-assets/sounddogs/explosion.mp3")\
\
# helper functions to handle transformations\
def angle_to_vector(ang):\
    return [math.cos(ang), math.sin(ang)]\
\
def dist(p,q):\
    return math.sqrt((p[0] - q[0]) ** 2+(p[1] - q[1]) ** 2)\
\
\
# Ship class\
class Ship:\
    def __init__(self, pos, vel, angle, image, info):\
        self.pos = [pos[0],pos[1]]\
        self.vel = [vel[0],vel[1]]\
        self.thrust = False\
        self.angle = angle\
        self.angle_vel = 0\
        self.image = image\
        self.image_center = info.get_center()\
        self.image_size = info.get_size()\
        self.radius = info.get_radius()\
        \
    def draw(self,canvas):\
        if self.thrust:\
            center = [ship_info.center[0] + self.image_size[0], ship_info.center[1]]\
            canvas.draw_image(self.image,center, ship_info.size, self.pos, ship_info.size, self.angle)\
        else:\
            canvas.draw_image(self.image,ship_info.center, ship_info.size, self.pos, ship_info.size, self.angle)\
            \
    def check_boards(self):\
        \
        if self.pos[0] < 0:\
           self.pos[0] += WIDTH\
            \
        elif self.pos[0] > WIDTH:\
           self.pos[0] -= WIDTH\
        \
        if self.pos[1] < 0:\
           self.pos[1] += HEIGHT\
        \
        elif self.pos[1] > HEIGHT:\
           self.pos[1] -= HEIGHT\
            \
        \
    def update(self):\
        forward = angle_to_vector(self.angle)\
        \
        self.pos[0] += self.vel[0]\
        self.pos[1] += self.vel[1]\
        \
        self.check_boards()\
        \
        self.vel[0] *= (1 - FRICTION)\
        self.vel[1] *= (1 - FRICTION)\
        self.angle += self.angle_vel\
        \
        if self.thrust:\
 \
            self.vel[0] += forward[0] * ACELARATION\
            self.vel[1] += forward[1] * ACELARATION\
            \
    \
    def increment_angular_vel(self, amount):\
        self.angle_vel += amount\
    \
    def decrement_angular_vel(self, amount):\
        self.angle_vel -= amount    \
        \
    def turn_thrusters(self, on):\
        self.thrust = on\
        \
    def shoot_missile(self):\
        global a_missile\
        forward = angle_to_vector(self.angle)\
        \
        vx = self.vel[0] + forward[0] * MISSEL_VEL\
        vy = self.vel[1] + forward[1] * MISSEL_VEL\
        \
        # Tip of cannon\
        x = self.pos[0] + forward[0] * self.radius\
        y = self.pos[1] + forward[1] * self.radius\
        \
        a_missile = Sprite([x,y], [vx,vy], self.angle, 0, missile_image, missile_info, missile_sound)\
        a_missile.update()\
        \
    \
    \
# Sprite class\
class Sprite:\
    def __init__(self, pos, vel, ang, ang_vel, image, info, sound = None):\
        self.pos = [pos[0],pos[1]]\
        self.vel = [vel[0],vel[1]]\
        self.angle = ang\
        self.angle_vel = ang_vel\
        self.image = image\
        self.image_center = info.get_center()\
        self.image_size = info.get_size()\
        self.radius = info.get_radius()\
        self.lifespan = info.get_lifespan()\
        self.animated = info.get_animated()\
        self.age = 0\
        \
        if sound:\
            sound.rewind()\
            sound.play()\
   \
    def draw(self, canvas):\
        canvas.draw_image(self.image,self.image_center, self.image_size, self.pos, self.image_size, self.angle)\
        \
    \
    def update(self):\
        \
        self.pos[0] += self.vel[0]\
        self.pos[1] += self.vel[1]        \
        self.angle += self.angle_vel\
           \
def draw(canvas):\
    global time\
    \
    # animiate background\
    time += 1\
    center = debris_info.get_center()\
    size = debris_info.get_size()\
    wtime = (time / 8) % center[0]\
    canvas.draw_image(nebula_image, nebula_info.get_center(), nebula_info.get_size(), [WIDTH / 2, HEIGHT / 2], [WIDTH, HEIGHT])\
    canvas.draw_image(debris_image, [center[0] - wtime, center[1]], [size[0] - 2 * wtime, size[1]], \
                                [WIDTH / 2 + 1.25 * wtime, HEIGHT / 2], [WIDTH - 2.5 * wtime, HEIGHT])\
    canvas.draw_image(debris_image, [size[0] - wtime, center[1]], [2 * wtime, size[1]], \
                                [1.25 * wtime, HEIGHT / 2], [2.5 * wtime, HEIGHT])\
\
    # draw ship and sprites\
    my_ship.draw(canvas)\
    a_rock.draw(canvas)\
    a_missile.draw(canvas)\
    \
    # update ship and sprites\
    my_ship.update()\
    a_rock.update()\
    a_missile.update()\
    canvas.draw_text("Lives : "+str(lives), ( 50, 50), 36, "white")\
    canvas.draw_text("Score : "+str(score), (550, 50), 36, "white")\
    \
            \
# timer handler that spawns a rock    \
def rock_spawner():\
    global a_rock\
    \
    x = random.randrange(0,WIDTH)\
    y = random.randrange(0,HEIGHT)\
    \
    vX = (random.randrange(0,3) + 1) * random.choice([-1,1])\
    vY = (random.randrange(0,3) + 1) * random.choice([-1,1])\
    \
    angle_vel = ((random.randrange(0,10) + 1) / 100) * random.choice([-1,1])\
    \
    a_rock = Sprite([x, y], [vX, vY], 0, angle_vel, asteroid_image, asteroid_info)\
    \
    \
# initialize frame\
frame = simplegui.create_frame("Asteroids", WIDTH, HEIGHT)\
\
# initialize ship and two sprites\
my_ship = Ship([WIDTH / 2, HEIGHT / 2], [0, 0], 0, ship_image, ship_info)\
a_rock = Sprite([WIDTH / 3, HEIGHT / 3], [1, 1], 0, 0, asteroid_image, asteroid_info)\
a_missile = Sprite([2 * WIDTH / 3, 2 * HEIGHT / 3], [-1,1], 0, 0, missile_image, missile_info, missile_sound)\
\
\
def keydown(key):\
    \
    if key == simplegui.KEY_MAP["left"]:\
        \
       my_ship.decrement_angular_vel(CONST_ANGLE)\
        \
    if key == simplegui.KEY_MAP["right"]:\
        my_ship.increment_angular_vel(CONST_ANGLE)\
    \
    if key == simplegui.KEY_MAP["up"]:\
        my_ship.turn_thrusters(True)\
        ship_thrust_sound.play()\
        \
    if key == simplegui.KEY_MAP["space"]:\
        my_ship.shoot_missile()\
    \
        \
   \
def keyup(key):\
    \
    global FRICTION\
    if key == simplegui.KEY_MAP["left"] or key == simplegui.KEY_MAP["right"]:\
       my_ship.angle_vel = 0     \
        \
    if key == simplegui.KEY_MAP["up"]:\
\
       my_ship.turn_thrusters(False)\
       ship_thrust_sound.rewind()\
\
\
\
\
\
# register handlers\
frame.set_draw_handler(draw)\
frame.set_keydown_handler(keydown)\
frame.set_keyup_handler(keyup)\
\
timer = simplegui.create_timer(1000.0, rock_spawner)\
\
# get things rolling\
timer.start()\
frame.start()\
}