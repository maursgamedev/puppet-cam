local Node = require 'src.nodes.Node'

local Node2D = class('Node2D', Node)

function Node2D:initialize(args)
	Node.initialize(self, args)
	self.position = args.position or vector(0,0)
	self.rotation = args.rotation or 0
	self.debugDraw = args.debugDraw -- move this to Node2D
	self.scale = args.scale or vector(1,1)
end

function Node2D:globalPosition()
	return (
		self.position * vector(
			math.abs(self.parent:globalScale().x),
			math.abs(self.parent:globalScale().y)
		)) + Node.globalPosition(self)
end

function Node2D:globalScale()
	return self.scale * self.parent:globalScale()
end

function Node2D:draw(ctx)
	if self.debugDraw then
		ctx.setColor(1,0,0)
		ctx.circle('fill', self:globalPosition().x, self:globalPosition().y, 10, 100)
		ctx.setColor(1,1,1)
	end
	Node.draw(self, ctx)
end

return Node2D