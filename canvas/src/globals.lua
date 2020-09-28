microphone = require 'ext.love-microphone.love-microphone'
Collection = require 'ext.lua-collections.collections'
vector = require 'ext.vector.vector'
class = require 'ext.middleclass.middleclass'

game = {
	originalScreenHeight = 0,
	originalScreenWidth = 0,
	screenHeight = 0,
	screenWidth = 0,
	screenSizeLoaded = false,
	screenResizeCooldown = 0.01
}

local ffi = require 'ffi'

ffi.cdef[[
	typedef unsigned long Uint32;
	Uint32 SDL_GetGlobalMouseState(int* x, int* y);
]]

local SDL = (ffi.os == "Windows") and ffi.load("SDL2") or ffi.C

function mouseFromCenter()
	local posPointerX = ffi.new('int[1]', {})
	local posPointerY = ffi.new('int[1]', {})
	SDL.SDL_GetGlobalMouseState(posPointerX, posPointerY)
	local centerX = game.screenWidth/2
	local centerY = game.screenHeight/2
	return vector(posPointerX[0] - centerX, posPointerY[0] - centerY)
end

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