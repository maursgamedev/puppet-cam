local Node = require 'src.nodes.Node'

local Node2D = class('Node2D', Node)

function Node2D:initialize(args)
	Node.initialize(self, args)
	self.position = args.position or vector(0,0)
end

function Node2D:globalPosition()
	local position = self.position
	if self.parent:isInstanceOf(Node2D) then
		position = position + self.parent:globalPosition()
	end
	return position
end

return Node2D