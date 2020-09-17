--[[
	Records a user's microphone and echos it back to them.

	This variant uses "fast as possible mode" to get a lower latency audio stream.
]]

-- Alias love-microphone as microphone
microphone = require 'lib.love-microphone.love-microphone'
Collection = require 'lib.lua-collections.collections'
vector = require 'lib.vector.vector'
class = require 'lib.middleclass.middleclass'

local device, source
local currentWave = collect({0,0})

function love.load()
	-- Report the name of the microphone we're going to use
	print("Opening microphone:", microphone.getDefaultDeviceName())

	-- Open the default microphone device with default quality and as little latency as possible.
	device = microphone.openDevice(nil, nil, 0)

	-- Create a new QueueableSource to echo our audio
	source = microphone.newQueueableSource()

	-- Register our local callback
	device:setDataCallback(function(device, data)
		currentWave = collect({})
		for i = 0, data:getSampleCount()-1 do
			currentWave:push(data:getSample(i))
		end
	end)

	-- Start recording
	device:start()
end

function love.draw()
	local amplitude = math.abs(currentWave:min() - currentWave:max())/2
	love.graphics.rectangle('fill', 300, 300, 30, -100 * amplitude)
end

-- Add microphone polling to our update loop
function love.update()
	device:poll()
end
