local anim8 = require("libraries.anim8")

function love.load()
	--print("load - once on start the game")

	love.graphics.setDefaultFilter("nearest", "nearest")

	Player = {}
	Player.x = 200
	Player.y = 200
	Player.speed = 3
	--Player.sprite = love.graphics.newImage("sprites/parrot.png")
	Player.sprite = love.graphics.newImage("sprites/player-sheet.png")
	Player.grid = anim8.newGrid(12, 18, Player.sprite:getWidth(), Player.sprite:getHeight())

	Player.animations = {}
	Player.animations.down = anim8.newAnimation(Player.grid("1-4", 1), 0.2)
	Player.animations.left = anim8.newAnimation(Player.grid("1-4", 2), 0.2)
	Player.animations.right = anim8.newAnimation(Player.grid("1-4", 3), 0.2)
	Player.animations.up = anim8.newAnimation(Player.grid("1-4", 4), 0.2)

	Player.anim = Player.animations.down

	Game = {}
	Game.background = love.graphics.newImage("sprites/background.png")
end

function love.update(dt)
	--print("update " .. dt)

	local isMoving = false

	if love.keyboard.isDown("right") then
		Player.x = Player.x + Player.speed
		Player.anim = Player.animations.right
		isMoving = true
	end
	if love.keyboard.isDown("left") then
		Player.x = Player.x - Player.speed
		Player.anim = Player.animations.left
		isMoving = true
	end
	if love.keyboard.isDown("down") then
		Player.y = Player.y + Player.speed
		Player.anim = Player.animations.down
		isMoving = true
	end
	if love.keyboard.isDown("up") then
		Player.y = Player.y - Player.speed
		Player.anim = Player.animations.up
		isMoving = true
	end

	if isMoving == false then
		Player.anim:gotoFrame(2)
	end

	Player.anim:update(dt)
end

function love.draw()
	--print("draw")

	--love.graphics.circle("fill", Player.x, Player.y, 100)
	love.graphics.draw(Game.background, 0, 0)
	--love.graphics.draw(Player.sprite, Player.x, Player.y)
	Player.anim:draw(Player.sprite, Player.x, Player.y, nil, 6)
end
