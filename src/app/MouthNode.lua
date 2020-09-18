local Node2D = require 'src.nodes.Node2D'

local MouthNode = class('MouthNode', Node2D)

function MouthNode:onLoad()
	print("Opening microphone:", microphone.getDefaultDeviceName())

	self.device = microphone.openDevice(nil, nil, 0)
	self.source = microphone.newQueueableSource()
	self.currentWave = collect({})

	self.device:setDataCallback(function(device, data)
		self.currentWave = collect({})
		for i = 0, data:getSampleCount()-1 do
			self.currentWave:push(data:getSample(i))
		end
	end)

	self.device:start()
end

function MouthNode:getAmplitude()
	if self.currentWave:count() <= 0 then
		return 0.0
	end

	return math.abs(self.currentWave:min() - self.currentWave:max())
end

function MouthNode:onReady()

end

function MouthNode:process(delta)
	self.device:poll()
	
	local amplitude = self:getAmplitude()
	self.children:each(function(k, child)
		child.visible = false
	end)

	local currentMouthIndex = math.floor(
		math.clamp(
			((amplitude*2 + 0.05) * self.children:count()) +1, 1, 
			self.children:count()
		)
	)
	self.children:get(currentMouthIndex).visible = true
end

return MouthNode