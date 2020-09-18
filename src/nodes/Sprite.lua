local Node2D = require 'src.nodes.Node2D'

local Sprite = class('Sprite', Node2D)

function Sprite:initialize(args)
	Node2D.initialize(self, args)
	self.image = args.image
	self.drawCenter = args.drawCenter
	self.scaleX = args.scaleX or 1
	self.scaleY = args.scaleY or 1
	self.rotation = 0

	if args.visible == nil then
		self.visible = true
	else
		self.visible = args.visible
	end
end

function Sprite:draw(ctx)
	if self.visible then
		local position = self:globalPosition()
		local corner = position - (vector(self.image:getHeight() * self.scaleX, self.image:getWidth() * self.scaleY) / 2)
		ctx.draw(
			self.image, 
			corner.x, 
			corner.y, 
			self.rotation,
			self.scaleX,
			self.scaleY
		)
	end
	Node2D.draw(self, ctx)
end

return Sprite