local Node2D = require 'src.nodes.Node2D'

local FaceNode = class('FaceNode', Node2D)

local states = {
	open = 0,
	closing = 1,
	closed = 2,
	opening = 3,
}

local stateToStr = {

}

local stateTimers = {}
stateTimers[states.open] = function() return love.math.random(0.01, 4) end
stateTimers[states.closing] = function() return 0.05 end
stateTimers[states.closed] = function() return 0.1 end
stateTimers[states.opening] = function() return 0.05 end

local processState = {}

processState[states.open] = function(self, face, delta)
	self.position.y = face.openY
end

processState[states.closing] = function(self, face, delta)
	self.position.y = math.lerp(
		face.closedY,
		face.openY,
		face.countdown / face.maxCountdown
	)
end

processState[states.closed] = function(self, face, delta)
	self.position.y = face.closedY
end

processState[states.opening] = function(self, face, delta)
	self.position.y = math.lerp(
		face.openY, 
		face.closedY, 
		face.countdown / face.maxCountdown
	)
end

function FaceNode:onReady()
	self.state = states.open
	self:resetCountdown()
	self.closedY = -6
	self.openY = -27
	self.startingPosition = self.position
	self.irises = collect({
		self:getNode('LeftEye/Iris'),
		self:getNode('RightEye/Iris')
	})
	self.upperPalpabra = collect({
		self:getNode('LeftEye/UpperPalpebra'),
		self:getNode('RightEye/UpperPalpebra'),
	})
end

function FaceNode:resetCountdown()
	self.countdown = stateTimers[self.state]()
	self.maxCountdown = self.countdown
end

function FaceNode:checkForNextState(delta)
	self.countdown = self.countdown - delta
	if self.countdown < 0.0 then
		self:nextState()
	end
end

function FaceNode:nextState()
	self.state = math.wrap(self.state + 1, 0, 4)
	self:resetCountdown()
end

function FaceNode:process(delta)
	local distanceFromCenter = 0.0
	if mouseFromCenter():length() > 100.0 then
		distanceFromCenter = mouseFromCenter():norm()
	else
		distanceFromCenter = mouseFromCenter() / 100
	end
	self.position = self.startingPosition + distanceFromCenter * 2
	self.irises:each(function(k, iris)
		iris.position = distanceFromCenter * 2
	end)

	self.upperPalpabra:each(function(k, palpebra) 
		processState[self.state](palpebra, self, delta)
	end)

	self:checkForNextState(delta)
end

return FaceNode