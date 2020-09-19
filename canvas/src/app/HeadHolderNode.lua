local Node2D = require 'src.nodes.Node2D'

local HeadHolderNode = class('HeadHolderNode', Node2D)

function HeadHolderNode:onReady()
	self.earSprites = collect({
		self:getNode('LeftEar'),
		self:getNode('LeftEarBorder'),
		self:getNode('RightEar'),
		self:getNode('RightEarBorder'),
	})

	local startingPositions = {}
	self.earSprites:each(function(k, value) 
		startingPositions[value.name] = value.position
	end)
	self.startingPositions = startingPositions
end

function HeadHolderNode:process(delta)
	local mouseFromCenter = vector(love.mouse.getX() - 400, love.mouse.getY() - 300)
	local distanceFromCenter = 0.0
	if mouseFromCenter:length() > 100.0 then
		distanceFromCenter = mouseFromCenter:norm()
	else
		distanceFromCenter = mouseFromCenter / 100
	end
	local face = self
	self.earSprites:each(function(k, sprite)
		sprite.position = face.startingPositions[sprite.name] + (distanceFromCenter * -1)
	end)
end

return HeadHolderNode