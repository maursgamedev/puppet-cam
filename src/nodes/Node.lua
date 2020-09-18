local Node = class('Node')

function Node:initialize(args)
	self.name = args.name or nil
	self.parent = args.parent or nil
	self.children = args.children or collect({})

	self.children:each(function (k,child)
		child.parent = self
	end)
end

function Node:ready()
	self.children:each(function(k, child) 
		child:ready()
	end)
	if self.class.onReady then
		self:onReady()
	end
end

function Node:update(delta)
	if self.class.process then
		self:process(delta)
	end
	self.children:each(function(k, child) 
		child:update(delta)
	end)
end

function Node:load()
	if self.class.onLoad then
		self:onLoad()
	end

	self.children:each(function(k, child) 
		child:load()
	end)

	self:ready()
end

function Node:draw(ctx)
	if self.class.onDraw then
		self:onDraw(ctx)
	end

	self.children:each(function(k, child)
		child:draw(ctx)
	end)
end

return Node