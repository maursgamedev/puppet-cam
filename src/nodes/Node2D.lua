local Node = require 'src.nodes.Node'

local Node2D = class('Node2D', Node)

function Node2D:initialize(args)
	Node.initialize(self, args)
	self.position = args.position or vector(0,0)
	self.debugDraw = args.debugDraw -- move this to Node2D
end

function Node2D:globalPosition()
	local position = self.position
	if self.parent:isInstanceOf(Node2D) then
		position = position + self.parent:globalPosition()
	end
	return position
end

function Node2D:draw(ctx)
	if self.debugDraw then
		ctx.setColor(1,1,1)
		ctx.circle('fill', self:globalPosition().x, self:globalPosition().y, 10, 100)
	end
	Node.draw(self, ctx)
end

return Node2D