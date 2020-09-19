local Node = class('Node')

-------------------------------------
local nullParent = {}

function nullParent:globalScale()
	return vector(1,1)
end

function nullParent:globalPosition()
	return vector(0,0)
end

------------------------------------

function Node:getNextInstanceID()
	local count = self.class.static.instanceCount or 0
	if not self.class.static.instanceCount then
		self.class.static.instanceCount = 0
	end
	self.class.static.instanceCount = self.class.static.instanceCount + 1
	return count
end

function Node:initialize(args)
	self.name = args.name or (self.class.name .. self:getNextInstanceID())
	self.parent = args.parent or nullParent
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
end

function Node:draw(ctx)
	if self.class.onDraw then
		self:onDraw(ctx)
	end

	self.children:each(function(k, child)
		child:draw(ctx)
	end)
end

function Node:getNode(nodeName)
	return self:_getNode(split(nodeName, '/'), nodeName)
end

function Node:_getNode(nodeNameCollection, fullNodeName)
	local nodeName = nodeNameCollection:shift()
	local hit = Node({})

	if nodeName == '..' then
		hit = parent
	end
	
	if nodeName ~= '..' and self.children then
		hit = self.children:first(function (k, child)
			return child.name == nodeName
		end)
	end

	-- Couldn't find the Node
	if not hit then
		print('nodeName', nodeName)
		print('self.name', self.name)
		print(children)
		self.children:map('name'):each(print)
		assert(false, 'Node not found: "' .. fullNodeName .. '"')
		return nil
	end
	-- Node is on a deeper level
	if nodeNameCollection:count() > 0 then
		-- print('nodeNameCollection', nodeNameCollection)
		hit = hit:_getNode(nodeNameCollection, fullNodeName)
	end
	return hit
end

function Node:globalPosition()
	local position = vector()
	position = position + self.parent:globalPosition()
	return position
end

function Node:globalScale()
	return vector(1,1) * self.parent:globalScale()
end


return Node