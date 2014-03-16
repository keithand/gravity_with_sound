-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

-----------------------------------------
----------REMOVE STATUS BAR--------------
-----------------------------------------

display.setStatusBar( display.HiddenStatusBar )

-----------------------------------------
----------EXPLOSION SPRITESHEET----------
-----------------------------------------

local explosion_sheet = graphics. newImageSheet("images/explosion.png", {width=50, height=50, numFrames=81})

-----------------------------------------
-------------LOADED SOUNDS---------------
-----------------------------------------

local explosion_sound = audio.loadSound("sound/boom.wav")
local ambient_sound = audio.loadStream("sound/ambient.aiff")

-----------------------------------------
-------------PLAY AMBIENT SOUND----------
-----------------------------------------

audio.play(ambient_sound, {channel= 1, fadein= 0, loops=-1})
audio.setVolume(0.2, {channel=1})
-----------------------------------------
----------STATIC BACKGROUND DISPLAY------
-----------------------------------------

local background = display.newImageRect("images/background.png", 340, 570)
background.x = display.contentCenterX
background.y = display.contentCenterY

--------------------------------------
--------- BACK STARS------------------
--------------------------------------

local back_stars = display.newImage("images/back_stars.png", 620, 454)
back_stars.x = 0
back_stars.y = 320

transition.to(back_stars, {x=320, time=55000, delay=none, iterations=999})

---------------------------------------
--------- FRONT STARS -----------------
---------------------------------------

local front_stars = display.newImage("images/front_stars.png", 508, 450)
front_stars.x = 0
front_stars.y = 320

transition.to(front_stars, {x=246, time=43000, iterations=999})


---------------------------------------
--------- JUPITER ---------------------
---------------------------------------

local function reset_jupiter( jupiter )
	jupiter.x = -500
	jupiter.y = 200
	transition.to(jupiter, {x = display.contentWidth + 150, time= 60000, onComplete = reset_jupiter})
end

local jupiter = display.newImage("images/jupiter.png", 25, 25)
jupiter.x = -500
jupiter.y = 200

transition.to (jupiter, {x = display.contentWidth + 150, time = 70000, onComplete = reset_jupiter})

---------------------------------------
--------- MARS ------------------------
---------------------------------------

local function reset_mars(mars)
	mars.x = -400
	mars.y = 380
	transition.to(mars, {x = display.contentWidth + 150, time=50500, onComplete=reset_mars})
end


local mars = display.newImage("images/mars.png", 30, 30)
mars.x = 200
mars.y = 380

transition.to( mars, {x = display.contentWidth +150, time = 50500, onComplete= reset_mars})

---------------------------------------
--------- EARTH -----------------------
---------------------------------------

local function reset_earth( earth )
	earth.x = -200
	earth.y = 300
	transition.to(earth, {x = display.contentWidth + 150, time= 54000, onComplete = reset_earth})
end

local earth = display.newImage("images/earth.png", 45, 45)
earth.x = -200
earth.y = 300

transition.to (earth, {x = display.contentWidth + 200, time =54000, onComplete = reset_earth})

---------------------------------------
--------- EXPLOSION -------------------
---------------------------------------

local function remove_explosion(event)
	if event.phase == "ended" then
		display.remove(event.target)
	end
end

local function make_explosion()
	local explosion_sprite = display.newSprite (explosion_sheet, {start=15, count=50, loopCount=1, timeScale=2.0})
	explosion_sprite:addEventListener("sprite", remove_explosion)
	explosion_sprite:play()
	return explosion_sprite
end

local function on_touch(event)
	if event.phase == "began" then
		local explosion = make_explosion()
		explosion.x = event.x
		explosion.y = event.y
	end
end

Runtime:addEventListener("touch", on_touch)


---------------------------------------
--------- ASTRONAUT -------------------
---------------------------------------

local function reset_astro(astro)
transition.to(astro, {x=math.random(50,310), y=math.random(100, 460), time=20000, rotation=200, onComplete = reset_astro})
end

local function touch_astro(event)
	if event.phase == "began" then
		local explosion_sprite = make_explosion()
		explosion_sprite.x = event.target.x
		explosion_sprite.y = event.target.y
		audio.play(explosion_sound)
		audio.setVolume(0, {channel=1})

		display.remove(astro)
		local redBack = display.newRect(180, 260, 360, 580)
		redBack:setFillColor(.84, .19, .09, 1)
		transition.to(redBack,{time=1000})

		local gameOver = display.newImage("images/gameover.png", 320, 480)
		gameOver.x = 160
		gameOver.y = 230
		gameOver.alpha = 0
		transition.to(gameOver, {time=1000, alpha=1})
	end
	return true
end

local astro = display.newImage('images/astro.png', 35, 30)
astro.x = 170
astro.y = 250
astro.rotation = 0
transition.to(astro, {delay=1000, x=math.random(100,330), y=math.random(300, 450), rotation=200, time=10000, onComplete = reset_astro})
astro:addEventListener("touch", touch_astro)



---------------------------------------
--------- METEOR EVENTS ---------------
---------------------------------------


local function reset_meteor(meteor)
	meteor.x = -100
	meteor.y = math.random(30, 500)

	if meteor.t ~= nil then
		transition.cancel(meteor.t)
	end

	meteor.t = transition.to(meteor, {
		x = display.contentWidth + 150, y=math.random(30, 500),
		time=math.random(1000, 10000),
		rotation = math.random(100, 1000),
		onComplete = reset_meteor
		})
end

local function touch_meteor(event)
	if event.phase == "began" then
		local explosion_sprite = make_explosion()
		explosion_sprite.x = event.target.x
		explosion_sprite.y = event.target.y
		audio.play(explosion_sound)
		reset_meteor(event.target)
		print("Just destroyed a meteor")
	end
	return true
end

---------------------------------------
--------- METEOR_1 --------------------
---------------------------------------

	local meteor_1 = display.newImage("images/meteor_1.png", 50, 50)
	meteor_1.x = -150
	meteor_1.y = math.random(50, 470)
	meteor_1:addEventListener("touch", touch_meteor)
	reset_meteor(meteor_1)

---------------------------------------
--------- METEOR_2 ------------------------
---------------------------------------

	local meteor_2 = display.newImage("images/meteor_2.png", 55, 55)
	meteor_2.x = -200
	meteor_2.y = math.random(50, 470)
	meteor_2:addEventListener("touch", touch_meteor)
	reset_meteor(meteor_2)
---------------------------------------
--------- METEOR_3 --------------------
---------------------------------------

	local meteor_3 = display.newImage("images/meteor_3.png", 45, 45)
	meteor_3.x = -300
	meteor_3.y = math.random(50, 470)
	meteor_3:addEventListener("touch", touch_meteor)
	reset_meteor(meteor_3)

---------------------------------------
--------- METEOR_4 --------------------
---------------------------------------

	local meteor_4 = display.newImage("images/meteor_4.png", 40, 40)
	meteor_4.x = -100
	meteor_4.y = math.random(50, 470)
	meteor_4:addEventListener("touch", touch_meteor)
	reset_meteor(meteor_4)

---------------------------------------
--------- METEOR_5 --------------------
---------------------------------------

	local meteor_5 = display.newImage("images/meteor_5.png", 50, 50)
	meteor_5.x = -500
	meteor_5.y = math.random(50, 470)
	meteor_5:addEventListener("touch", touch_meteor)
	reset_meteor(meteor_5)

---------------------------------------
--------- METEOR_6 --------------------
---------------------------------------

	local meteor_6 = display.newImage("images/meteor_6.png", 55, 55)
	meteor_6.x = -10
	meteor_6.y = math.random(50, 470)
	meteor_6:addEventListener("touch", touch_meteor)
	reset_meteor(meteor_6)

---------------------------------------
--------- METEOR_7 --------------------
---------------------------------------

	local meteor_7 = display.newImage("images/meteor_7.png", 50, 50)
	meteor_7.x = -20
	meteor_7.y = math.random(50, 470)
	meteor_7:addEventListener("touch", touch_meteor)
	reset_meteor(meteor_7)

---------------------------------------
--------- METEOR_8 --------------------
---------------------------------------

	local meteor_8 = display.newImage("images/meteor_8.png", 50, 50)
	meteor_8.x = -70
	meteor_8.y = math.random(50, 470)
	meteor_8:addEventListener("touch", touch_meteor)
	reset_meteor(meteor_8)

---------------------------------------
--------- SPACE STATION ---------------
---------------------------------------

	local function reset_space_station(ship)
		ship.x = -100
		ship.y = math.random(150, 450)


	ship.t = transition.to(ship, {
		x = display.contentWidth + math.random(300,500), y=math.random(80, 450),
		time=40000,
		rotation = math.random(100, 200),
		onComplete = reset_space_station
		})

	end


	local space_station = display.newImage("images/space_station.png", 60, 34)
	space_station.x = 40
	space_station.y = 200
	space_station.rotation = 400
	transition.to(space_station, {delay=1000, x= display.contentWidth + 100, y=200, rotation=200, time=100, onComplete = reset_wing})
	reset_space_station(space_station)
	space_station:addEventListener("touch", touch_astro)

---------------------------------------
--------- TITLE BACKGROUND ------------
---------------------------------------

local title_background = display.newRect(160, 240, 320, 480)
title_background:setFillColor(0, 0, 0, 1)

transition.to (title_background, { time=12000, alpha=0, })


---------------------------------------
--------- TITLE -----------------------
---------------------------------------

local title = display.newImage("images/gravity.png", 320, 480)
title.x = 160
title.y = 250

transition.to (title, { time=3500, alpha=0, })

local directions = display.newImage("images/directions.png", 320, 480)
directions.x = 160
directions.y = 250
directions.alpha = 0

transition.to(directions, {delay=2000, alpha=1, time=1000})
transition.to(directions, {delay=9000, alpha=0, time=1000})



