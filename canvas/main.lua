--[[
	Records a user's microphone and echos it back to them.

	This variant uses "fast as possible mode" to get a lower latency audio stream.
]]

require 'src.globals'

local Node = require 'src.nodes.Node'
local Text = require 'src.nodes.Text'

local root
local canvas

function love.load()
	canvas = love.graphics.newCanvas()

	root = Node({
		name = 'Root',
		children = collect({
			require('src.app.scenes.CharacterHead')}
		)
	})

	root:load()
	root:ready()
end

function love.draw()
	if root and canvas then
		--canvas:renderTo(function() 
			root:draw(love.graphics)
		--end)
		--love.graphics.draw(canvas, -400, -200, 0, 2, 2)
	end
	love.graphics.print('x: '.. love.mouse.getX() .. ' y: '.. love.mouse.getY(), 10, 10)
end

-- Add microphone polling to our update loop
function love.update(delta)
	if root then 
		root:update(delta)
	end
end