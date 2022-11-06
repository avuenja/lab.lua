function love.load()
	--print("load - once on start the game")

	Player = {}
	Player.x = 200
	Player.y = 200
	Player.speed = 3
	Player.sprite = love.graphics.newImage("sprites/parrot.png")

	Game = {}
	Game.background = love.graphics.newImage("sprites/background.png")
end

function love.update(dt)
	--print("update " .. dt)

	if love.keyboard.isDown("right") then
		Player.x = Player.x + Player.speed
	end
	if love.keyboard.isDown("left") then
		Player.x = Player.x - Player.speed
	end
	if love.keyboard.isDown("down") then
		Player.y = Player.y + Player.speed
	end
	if love.keyboard.isDown("up") then
		Player.y = Player.y - Player.speed
	end
end

function love.draw()
	--print("draw")

	--love.graphics.circle("fill", Player.x, Player.y, 100)
	love.graphics.draw(Game.background, 0, 0)
	love.graphics.draw(Player.sprite, Player.x, Player.y)
end
