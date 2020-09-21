local Node = require 'src.nodes.Node'
local Node2D = require 'src.nodes.Node2D'
local Sprite = require 'src.nodes.Sprite'
local MouthNode = require 'src.app.nodes.MouthNode'
local FaceNode = require 'src.app.nodes.FaceNode'
local HeadHolderNode = require 'src.app.nodes.HeadHolderNode'

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
	ear = 'assets/ear.png',
	ear_border = 'assets/ear_border.png',
	hair = 'assets/hair.png',
	torso = 'assets/torso.png',
	glasses = 'assets/glasses.png',
}):map(function(k, value) return k, love.graphics.newImage(value) end):all()

local leftEye = Node2D({
	name = 'LeftEye',
	position = vector(-27, -3),
	children = collect({
		Sprite({name = 'White', image = assets.eye_white}),
		Sprite({name = 'Iris', image = assets.eye_iris}),
		Sprite({name = 'UpperPalpebra', image = assets.eye_upperPalpebra, position = vector(0, -27)}),
		Sprite({name = 'LowerPalpebra', image = assets.eye_lowerPalpebra, position = vector(0, 10)}),
		Sprite({name = 'Eyebrow', image = assets.eye_eyebrow, position = vector(0, -17)})
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
		Sprite({name = 'Eyebrow', image = assets.eye_eyebrow, position = vector(0, -17)})
	})
})

local face = FaceNode({
	name = 'Face',
	position = vector(0,17),
	children = collect({
		Sprite({
			name = 'Nose',
			position = vector(0,10),
			image = assets.nose
		}),
		leftEye,
		rightEye,
		Sprite({
			name = 'Glasses',
			position = vector(0,-5),
			image = assets.glasses
		}),
		MouthNode({
			name = 'Mouth',
			position = vector(0, 30),
			children = mouths
		}),
	}),
})

return HeadHolderNode({
	-- scale = vector(2,2),
	position = vector((love.graphics.getWidth()/2), (love.graphics.getHeight()/2)),
	children = collect({
		Sprite({
			name = 'Torso',
			image = assets.torso,
			position = vector(0, 94)
		}),
		Sprite({
			name = 'LeftEarBorder',
			image = assets.ear_border,
			position = vector(-62, 8)
		}),
		Sprite({
			name = 'RightEarBorder',
			image = assets.ear_border,
			scale = vector(-1, 1),
			position = vector(62, 8)
		}),
		Sprite({
			name = 'Head',
			image = assets.head,
			children = collect({face})
		}),
		Sprite({
			name = 'LeftEar',
			image = assets.ear,
			position = vector(-62, 8)
		}),
		Sprite({
			name = 'RightEar',
			image = assets.ear,
			scale = vector(-1, 1),
			position = vector(62, 8)
		}),
		Sprite({
			name = 'Hair',
			image = assets.hair,
			position = vector(-6, -23)
		})
	})
})