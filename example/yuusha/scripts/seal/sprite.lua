local sprite_core = require "sprite_core"

local sprite_frame = require "seal.sprite_frame"
local sprite = {}

local all_sprites = {}

local function gc(self)
	sprite_core.free(self.__cobj)
end

function sprite.new(...) 
	local self = {}
	setmetatable(self, {__index = sprite, __gc = gc})
	self:ctor(...)
	all_sprites[self] = self
	return self
end

function sprite.new_container(...)
	local self = {}
	setmetatable(self, {__index = sprite, __gc = gc})
	self.__cobj = sprite_core.new_container(...)
	return self
end

-- frame_name must be unique in all of the texture
function sprite:ctor(frame_name, atlas_name)
	local frame = sprite_frame.get(frame_name, atlas_name)

	self.__cobj = sprite_core.new(frame.__cobj)
end

function sprite:set_pos(x, y)
	sprite_core.set_pos(self.__cobj, x, y)
end

function sprite:set_scale(scale)
	sprite_core.set_scale(self.__cobj, scale)
end

function sprite:set_rotation(rotation)
	sprite_core.set_rotation(self.__cobj, rotation)
end

function sprite:add_child(child)
	sprite_core.add_child(self.__cobj, child.__cobj)
end

function sprite:get_pos()
	return sprite_core.get_pos(self.__cobj)
end

function sprite:set_anim(frames)
	sprite_core.set_anim(self.__cobj, frames, #frames)
end

return sprite