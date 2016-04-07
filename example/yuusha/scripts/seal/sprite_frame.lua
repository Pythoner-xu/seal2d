--[[
	spriteframe never frees, it will not take up too much memory.
]]

local platform = require "seal.platform"
local cjson = require "cjson"

local sprite_frame = {}

local function gc(self)
	sprite_frame_free(self.__cobj)
end

function sprite_frame.new_frame(frame_name, atlas_name)
	local self = {}
	setmetatable(self, {__index = sprite_frame, __gc = gc})

	self.__cobj = sprite_frame_load(frame_name, atlas_name)
	self.ref = 0

	return self
end

local frames = {}
local frame_id_map = {}

local function gen_fid(frame_name, atlas_name)
	return atlas_name .. "-" .. frame_name
end

function sprite_frame.load_from_json(json_path)
	local data = platform.read_s(json_path)
	local frames = cjson.decode(data)
	print_r(frames)
end

function sprite_frame.get(frame_name, atlas_name)
	local id = gen_fid(frame_name, atlas_name)
	local f = frames[id]
	if not f then
		f = sprite_frame.new(frame_name, atlas_name)
		frames[id] = f
		f.ref = 0
		frame_id_map[f] = id
	end
	f.ref = f.ref + 1
	return f
end

function sprite_frame.put(frame)
	frame.ref = frame.ref - 1
	if frame.ref == 0 then
		local id = frame_id_map[frame]
		frames[id] = nil
		frame_id_map[frame] = nil
		collectgarbage()
	end
end

function sprite_frame.load(frame_config_file)

	local frames = cjson.decode()
end

return sprite_frame