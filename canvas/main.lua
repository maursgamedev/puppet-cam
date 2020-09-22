require 'src.globals'

local Node = require 'src.nodes.Node'
local Text = require 'src.nodes.Text'

local root
local canvas
local isFullScreen

function love.load()
	canvas = love.graphics.newCanvas()
	root = Node({
		name = 'Root',
		children = collect({
			require('src.app.scenes.Character')}
		)
	})

	game.originalScreenHeight = love.graphics.getHeight()
	game.originalScreenWidth = love.graphics.getWidth()

	isFullScreen = love.window.setFullscreen(true)

	root:load()
	root:ready()
end

function love.draw()
	love.graphics.clear(0,1,0,1)
	if root and canvas then
		--canvas:renderTo(function() 
			root:draw(love.graphics)
		--end)
		--love.graphics.draw(canvas, -400, -200, 0, 2, 2)
	end
	--love.graphics.print('x: '.. mouseFromServer.x .. ' y: '.. mouseFromServer.y, 10, 10)
end

function love.update(delta)
	if root then 
		root:update(delta)
	end
	if not game.screenSizeLoaded and isFullScreen then
		game.screenHeight = love.graphics.getHeight()
		game.screenWidth = love.graphics.getWidth()
		game.screenResizeCooldown = game.screenResizeCooldown - delta
	end
	if game.screenResizeCooldown < 0 and not game.screenSizeLoaded then
		game.screenSizeLoaded = love.window.setMode(game.originalScreenWidth, game.originalScreenHeight, {fullscreen = false})
		love.mouse.setPosition( game.originalScreenWidth* 0.5, game.originalScreenHeight * 0.5 )
	end
end