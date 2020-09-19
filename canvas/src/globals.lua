microphone = require 'ext.love-microphone.love-microphone'
Collection = require 'ext.lua-collections.collections'
vector = require 'ext.vector.vector'
class = require 'ext.middleclass.middleclass'

function split(str, separator)
	local result = collect({})
	str:gsub("([^" .. separator .. "]*)", function(match)
		if match ~= "" then
			result:append(match)
		end
	end)
	return result
end

function math.clamp(low, n, high) 
	return math.min(math.max(n, low), high) 
end

function math.lerp(start, lerpEnd, time) 
	return start * (1-time) + lerpEnd * time 
end

function math.wrap(value, min, max)
	local range = max - min
	if range == 0 then 
		return min 
	else
		return min + ((((value - min) % range) + range) % range)
	end
end

function math.percentageOf(value, percentage)
	return (value/100)*percentage
end