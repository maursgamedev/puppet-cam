local Node2D = require 'src.nodes.Node2D'

local Sprite = class('Sprite', Node2D)

function Sprite:initialize(args)
	Node2D.initialize(self, args)
	self.image = args.image
	self.drawCenter = args.drawCenter

	if args.visible == nil then
		self.visible = true
	else
		self.visible = args.visible
	end
end

function Sprite:realWidth()
	return self.image:getWidth() * self:globalScale().x
end

function Sprite:realHeight()
	return self.image:getHeight() * self:globalScale().y
end

function Sprite:size()
	return vector(self:realWidth(), self:realHeight())
end

function Sprite:upperLeftCorner()
	return self:globalPosition() - (vector(self:realWidth(), self:realHeight()) / 2)
end

function Sprite:draw(ctx)
	if self.visible then
		local corner = self:upperLeftCorner()
		ctx.draw(
			self.image, 
			corner.x, 
			corner.y, 
			self.rotation,
			self:globalScale().x,
			self:globalScale().y
		)

		if self.debugDraw then
			local size = self:size()
			ctx.setColor(1,0,0)
			ctx.rectangle('line', corner.x, corner.y, size.x, size.y)
			ctx.setColor(1,1,1)
		end
	end
	Node2D.draw(self, ctx)
end

return Sprite