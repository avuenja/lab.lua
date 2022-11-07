local anim8 = require("libraries.anim8")
local sti = require("libraries.sti")
local camera = require("libraries.camera")

function love.load()
  --print("load - once on start the game")

  love.graphics.setDefaultFilter("nearest", "nearest")

  Player = {}
  Player.x = 200
  Player.y = 200
  Player.speed = 1

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
  Game.camera = camera()
  Game.background = love.graphics.newImage("sprites/background.png")
  Game.map = sti("maps/testMap.lua")
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

  Game.camera:lookAt(Player.x, Player.y)

  local width = love.graphics.getWidth()
  local height = love.graphics.getHeight()

  if Game.camera.x < width / 2 then
    Game.camera.x = width / 2
  end
  if Game.camera.y < height / 2 then
    Game.camera.y = height / 2
  end

  local mapW = Game.map.width * Game.map.tilewidth
  local mapH = Game.map.height * Game.map.tileheight

  if Game.camera.x > (mapW - width / 2) then
    Game.camera.x = (mapW - width / 2)
  end
  if Game.camera.y < (mapH - height / 2) then
    Game.camera.y = (mapH - height / 2)
  end
end

function love.draw()
  --print("draw")

  --love.graphics.circle("fill", Player.x, Player.y, 100)
  --love.graphics.draw(Game.background, 0, 0)
  --love.graphics.draw(Player.sprite, Player.x, Player.y)

  Game.camera:attach()
  Game.map:drawLayer(Game.map.layers["ground"])
  Game.map:drawLayer(Game.map.layers["trees"])
  Player.anim:draw(Player.sprite, Player.x, Player.y, nil, 1, nil, 6, 9)
  Game.camera:detach()

  love.graphics.print("HUD", 10, 10)
end
