local Node2D = require 'src.nodes.Node2D'

local Text = class('Text', Node2D)

function Text:initialize(args)
	Node2D.initialize(self, args)
	self.text = args.text or ''
	self.font = args.font
end

function Text:draw(ctx)
	if self.font then
		ctx.print(
			self.text, 
			self.font, 
			self:globalPosition().x,
			self:globalPosition().y,
			self.rotation,
			self:globalScale().x,
			self:globalScale().y
		)
	else
		ctx.print(
			self.text,
			self:globalPosition().x,
			self:globalPosition().y,
			self.rotation,
			self:globalScale().x,
			self:globalScale().y
		)
	end
	Node2D.draw(self, ctx)
end

return Text