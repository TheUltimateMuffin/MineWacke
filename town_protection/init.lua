meta_save_location = vector.new(0,0,0)

local function town_center_after_place_node(pos, placer, itemstack, pointed_thing)
	local meta = minetest.env:get_meta(pos)
	local protection_positions = {}
	meta:set_int("posx", 0)
	meta:set_int("posy", 0)
	meta:set_int("posz", 0)
	meta:set_int("negx", 0)
	meta:set_int("negy", 0)
	meta:set_int("negz", 0)
	meta:set_string("owner", placer:get_player_name())
	local save_meta = minetest.env:get_meta(meta_save_location)
	if save_meta:get_string("prot_saves") ~= "" then
		protection_positions = minetest.parse_json(save_meta:get_string("prot_saves"))
	end
	table.insert(protection_positions, pos)
	print(minetest.write_json(protection_positions).. "whoop")
	save_meta:set_string("prot_saves", minetest.write_json(protection_positions))
end

local function town_center_on_rightclick(pos, node, player, itemstack, pointed_thing)
	local meta = minetest.env:get_meta(pos)
	local form 
	--minetest.env:set_node_level(pos, 40)
	if player:get_player_name() ~= meta:get_string("owner") then
		--Formspec for buyer
		form = "size[13,10;]"..
        "list[current_player;main;4.5,6;8,4;]"
		minetest.show_formspec(player:get_player_name(), "Town Center", form)
	else
		--formspec for seller
		form = "size[10,10;]"..
		"field[1,1;2,1;plux;Positive X;0]"..
		"field[0,2;2,1;pluy;Positive Y;0]"..
		"field[2,2;2,1;pluz;Positive Z;0]"..
		"field[1,3;2,1;negx;Negative X;0]"..
		"field[5,1;2,1;negy;Negative X;0]"..
		"field[5,2;2,1;negz;Negative X;0]"..
		"button[8,2;2,1;set;Set Protection]"..
		"bgcolor[#008900b0;false]"..
		--these are to send the node's location as fields to the player when it receives a button press and makes a second formspec
		"field[0,0;0,0;posx;;"..pos["x"].."]"..
		"field[0,0;0,0;posy;;"..pos["y"].."]"..
		"field[0,0;0,0;posz;;"..pos["z"].."]"
		minetest.show_formspec(player:get_player_name(), "Town Center", form)
	end
end


local old_is_protected = minetest.is_protected
function minetest.is_protected(pos, name)
	local save_meta = minetest.env:get_meta(meta_save_location)
	local protection_positions = {}
	if save_meta:get_string("prot_saves") ~= "" then
		protection_positions = minetest.parse_json(save_meta:get_string("prot_saves"))
	end
	for a, pos_check in pairs(protection_positions) do
		local meta = minetest.env:get_meta(pos_check)
		if name ~= meta:get_string("owner") and 
		(pos.x < pos_check.x + meta:get_int("posx") and pos.y < pos_check.y + meta:get_int("posy") and pos.z < pos_check.z + meta:get_int("posz") and pos.x > pos_check.x - meta:get_int("negx") and pos.y > pos_check.y - meta:get_int("negy") and pos.z > pos_check.z - meta:get_int("negz")) then
			print("achoo")
			return true
		end	
	end

	return old_is_protected(pos, name)
	
end



minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "Town Center" then
		local meta = minetest.env:get_meta(vector.new(tonumber(fields.posx),tonumber(fields.posy),tonumber(fields.posz)))
		if fields.set == "Set Protection" then
			meta:set_int("posx", tonumber(fields.plux))
			meta:set_int("posy", tonumber(fields.pluy))
			meta:set_int("posz", tonumber(fields.pluz))
			meta:set_int("negx", tonumber(fields.negx))
			meta:set_int("negy", tonumber(fields.negy))
			meta:set_int("negz", tonumber(fields.negz))
		end
		
	end
end)

minetest.register_on_protection_violation(function(pos, name)
	print("hello")



end)


minetest.register_node("town_protection:town_center", {
	description = "Protection Block",
	tiles = {"house.png"},
	groups = {melty=3, oddly_breakable_by_hand=3, choppy=3},
	after_place_node = town_center_after_place_node,
	on_rightclick = town_center_on_rightclick,
})