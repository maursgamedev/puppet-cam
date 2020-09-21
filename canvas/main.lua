require 'src.globals'

local Node = require 'src.nodes.Node'
local Text = require 'src.nodes.Text'

local root
local canvas

local socket = require 'socket'
local ip = assert(socket.dns.toip('localhost'))
local udp = assert(socket.udp())

mouseFromServer = vector()

function love.load()
	print('Waiting for  on localhost')
	udp:setsockname(ip, 41234)
	udp:settimeout(0)
	canvas = love.graphics.newCanvas()
	root = Node({
		name = 'Root',
		children = collect({
			require('src.app.scenes.Character')}
		)
	})

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
	local received = udp:receive()
	if received then
		local coordTable = split(received, ',')
		mouseFromServer.x = tonumber(coordTable:get(1))
		mouseFromServer.y = tonumber(coordTable:get(2))
	end
end