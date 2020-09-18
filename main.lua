--[[
	Records a user's microphone and echos it back to them.

	This variant uses "fast as possible mode" to get a lower latency audio stream.
]]

function math.clamp(low, n, high) return math.min(math.max(n, low), high) end

microphone = require 'ext.love-microphone.love-microphone'
Collection = require 'ext.lua-collections.collections'
vector = require 'ext.vector.vector'
class = require 'ext.middleclass.middleclass'

local Node = require 'src.nodes.Node'
local Node2D = require 'src.nodes.Node2D'
local Sprite = require 'src.nodes.Sprite'
local MouthNode = require 'src.app.MouthNode'

local root
local canvas

function love.load()
	canvas = love.graphics.newCanvas()
	local mouthPositions = {
		vector(0,0), 
		vector(0,0),
		vector(2,0),
		vector(0,0),
	}
	local mouths = collect({
		'assets/mouth/0.png',
		'assets/mouth/1.png',
		'assets/mouth/2.png',
		'assets/mouth/3.png',
	}):map(function(k, value)
		return k, Sprite({
			name = 'mouth' .. k,
			position = mouthPositions[k],
			image = love.graphics.newImage(value)
		})
	end)

	local assets = collect({
		head = 'assets/head.png',
		eye_eyebrow = 'assets/eye/eyebrow.png',
		eye_iris = 'assets/eye/iris.png',
		eye_lowerPalpebra = 'assets/eye/lower_palpebra.png',
		eye_upperPalpebra = 'assets/eye/upper_palpebra.png',
		eye_white = 'assets/eye/white.png',
	}):map(function(k, value) return k, love.graphics.newImage(value) end):all()

	local leftEye = Node2D({
		name = 'LeftEye',
		position = vector(-9,-10),
		children = collect({
			Sprite({name = 'White', image = assets.eye_white}),
			Sprite({name = 'Iris', image = assets.eye_iris}),
			Sprite({name = 'UpperPalpebra', image = assets.eye_upperPalpebra, position = vector(0, -27)}),
			Sprite({name = 'LowerPalpebra', image = assets.eye_lowerPalpebra, position = vector(-10, 20)}),
			Sprite({name = 'Eyebrow', image = assets.eye_eyebrow, position = vector(-10, -5)})
		})
	})
	local rightEye = Node2D({
		name = 'RightEye',
		position = vector(36,-10),
		children = collect({
			Sprite({name = 'White', image = assets.eye_white, scaleX = -1}),
			Sprite({name = 'Iris', image = assets.eye_iris, position = vector(3,0)}),
			Sprite({name = 'UpperPalpebra', image = assets.eye_upperPalpebra, position = vector(0, -27), scaleX = -1}),
			Sprite({name = 'LowerPalpebra', image = assets.eye_lowerPalpebra, position = vector(10, 20), scaleX = -1}),
			Sprite({name = 'Eyebrow', image = assets.eye_eyebrow, position = vector(10, -5), scaleX = -1})
		})
	})
	local face = Node2D({
		name = 'Face',
		children = collect({
			leftEye,
			rightEye,
			MouthNode({
				name = 'Mouth',
				position = vector(5, 30),
				children = mouths
			}),
		}),
	})

	root = Node({
		name = 'Root',
		children = collect({
			Sprite({
				name = 'Head',
				position = vector(400,300),
				image = assets.head,
				children = collect({face})
			})
		})
	})

	root:load()
end

function love.draw()
	if root and canvas then
		--canvas:renderTo(function() 
			root:draw(love.graphics)
		--end)
		--love.graphics.draw(canvas, -400, -200, 0, 2, 2)
	end
end

-- Add microphone polling to our update loop
function love.update(delta)
	if root then 
		root:update(delta)
	end
end
