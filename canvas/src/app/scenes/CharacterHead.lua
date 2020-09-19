local Node = require 'src.nodes.Node'
local Node2D = require 'src.nodes.Node2D'
local Sprite = require 'src.nodes.Sprite'
local MouthNode = require 'src.app.MouthNode'
local FaceNode = require 'src.app.FaceNode'

local mouths = collect({
	'assets/mouth/0.png',
	'assets/mouth/1.png',
	'assets/mouth/2.png',
	'assets/mouth/3.png',
}):map(function(k, value)
	return k, Sprite({
		name = 'mouth' .. k,
		image = love.graphics.newImage(value)
	})
end)

local assets = collect({
	head = 'assets/head.png',
	nose = 'assets/nose.png',
	eye_eyebrow = 'assets/eye/eyebrow.png',
	eye_iris = 'assets/eye/iris.png',
	eye_lowerPalpebra = 'assets/eye/lower_palpebra.png',
	eye_upperPalpebra = 'assets/eye/upper_palpebra.png',
	eye_white = 'assets/eye/white.png',
}):map(function(k, value) return k, love.graphics.newImage(value) end):all()

local leftEye = Node2D({
	name = 'LeftEye',
	position = vector(-27, -3),
	children = collect({
		Sprite({name = 'White', image = assets.eye_white}),
		Sprite({name = 'Iris', image = assets.eye_iris}),
		Sprite({name = 'UpperPalpebra', image = assets.eye_upperPalpebra, position = vector(0, -27)}),
		Sprite({name = 'LowerPalpebra', image = assets.eye_lowerPalpebra, position = vector(0, 10)}),
		Sprite({name = 'Eyebrow', image = assets.eye_eyebrow, position = vector(0, -10)})
	})
})

local rightEye = Node2D({
	name = 'RightEye',
	position = vector(27,-3),
	scale = vector(-1, 1),
	children = collect({
		Sprite({name = 'White', image = assets.eye_white}),
		Sprite({name = 'Iris', image = assets.eye_iris, scale = vector(-1, 1)}),
		Sprite({name = 'UpperPalpebra', image = assets.eye_upperPalpebra, position = vector(0, -27)}),
		Sprite({name = 'LowerPalpebra', image = assets.eye_lowerPalpebra, position = vector(0, 10)}),
		Sprite({name = 'Eyebrow', image = assets.eye_eyebrow, position = vector(0, -10)})
	})
})

local face = FaceNode({
	name = 'Face',
	position = vector(0,13),
	children = collect({
		Sprite({
			name = 'Nose',
			position = vector(0,10),
			image = assets.nose
		}),
		leftEye,
		rightEye,
		MouthNode({
			name = 'Mouth',
			position = vector(0, 30),
			children = mouths
		}),
	}),
})

return Sprite({
	name = 'Head',
	scale = vector(2,2),
	position = vector(400,300),
	image = assets.head,
	children = collect({face})
})