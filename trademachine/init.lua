
local function trademachine_after_place_node(pos, placer, itemstack, pointed_thing)
	local meta = minetest.env:get_meta(pos)
	meta:set_string("setup_formspec",
        "size[13,10;]"..
        "list[current_name;selector;0.5,6.5;3,3;]"..
		"button[1,5;3,1;sell;Set Sell]"..
		"button[9,5;3,1;buy;Set Buy]"..
		"button[5,4;3,2;stock;Stock Machine]"..
		"list[current_name;sale_memory;1,2;3,3;]"..
		"list[current_name;buy_memory;9,2;3,3;]"..
		"image[1,1;3,1;selling.png]"..
		"image[9,1;3,1;buying.png]"..
		"image[3,0;7,1;trademachinetitle.png]"..
		"bgcolor[#ff8010b0;false]"..
        "list[current_player;main;4.5,6;8,4;]")
	meta:set_string("stock_formspec",
		"size[14,10;]"..
		"list[current_name;main;0,0;14,5;]"..
		"button[5,5;4,1;ret;Return]"..
		"bgcolor[#ff8010b0;false]"..
		"list[current_player;main;3,6;8,4;]")
	meta:set_string("buyer_formspec",
        "size[13,10;]"..
        "list[current_name;selector;0.5,6.5;3,3;]"..
		"button[5,4;3,2;purchase;Trade]"..
		"list[current_name;sale_memory;1,2;3,3;]"..
		"list[current_name;buy_memory;9,2;3,3;]"..
		"image[1,1;3,1;selling.png]"..
		"image[9,1;3,1;buying.png]"..
		"image[3,0;7,1;trademachinetitle.png]"..
		"bgcolor[#ff8010b0;false]"..
        "list[current_player;main;4.5,6;8,4;]")
	--meta:set_string("formspec",meta:get_string("setup_formspec"))
	meta:set_string("infotext", "Trade Machine")
	meta:set_string("owner", placer:get_player_name())
	local inv = meta:get_inventory()
	inv:set_size("main", 14*5)
	inv:set_size("selector", 3*3)
	inv:set_size("sale_memory", 3*3)
	inv:set_size("buy_memory", 3*3)
end

local function trademachine_on_rightclick(pos, node, player, itemstack, pointed_thing)
	local meta = minetest.env:get_meta(pos)
	print(pos)
	local form 
	if player:get_player_name() ~= meta:get_string("owner") then
		--Formspec for buyer
		form = "size[13,10;]"..
		"button[5,4;3,2;purchase;Trade]"..
		"list[nodemeta:"..pos["x"]..","..pos["y"]..","..pos["z"]..";sale_memory;1,2;3,3;]"..
		"list[nodemeta:"..pos["x"]..","..pos["y"]..","..pos["z"]..";buy_memory;9,2;3,3;]"..
		"image[1,1;3,1;buyer.png]"..
		"image[9,1;3,1;buying.png]"..
		"image[3,0;7,1;trademachinetitle.png]"..
		"bgcolor[#ff8010b0;false]"..
		"field[0,0;0,0;posx;;"..pos["x"].."]"..
		"field[0,0;0,0;posy;;"..pos["y"].."]"..
		"field[0,0;0,0;posz;;"..pos["z"].."]"..
        "list[current_player;main;4.5,6;8,4;]"
		minetest.show_formspec(player:get_player_name(), "Trade Machine", form)
	else
		--formspec for seller
		form = "size[13,10;]"..
        "list[nodemeta:"..pos["x"]..","..pos["y"]..","..pos["z"]..";selector;0.5,6.5;3,3;]"..
		"button[1,5;3,1;sell;Set Sell]"..
		"button[9,5;3,1;buy;Set Buy]"..
		"button[5,4;3,2;stock;Stock Machine]"..
		"list[nodemeta:"..pos["x"]..","..pos["y"]..","..pos["z"]..";sale_memory;1,2;3,3;]"..
		"list[nodemeta:"..pos["x"]..","..pos["y"]..","..pos["z"]..";buy_memory;9,2;3,3;]"..
		"image[1,1;3,1;selling.png]"..
		"image[9,1;3,1;buying.png]"..
		"image[3,0;7,1;trademachinetitle.png]"..
		"bgcolor[#ff8010b0;false]"..
		"field[0,0;0,0;posx;;"..pos["x"].."]"..
		"field[0,0;0,0;posy;;"..pos["y"].."]"..
		"field[0,0;0,0;posz;;"..pos["z"].."]"..
        "list[current_player;main;4.5,6;8,4;]"
		minetest.show_formspec(player:get_player_name(), "Trade Machine", form)
	end
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "Trade Machine" then
		local meta = minetest.env:get_meta(vector.new(tonumber(fields.posx),tonumber(fields.posy),tonumber(fields.posz)))
		local inv = meta:get_inventory()
		if fields.sell == "Set Sell" then
			local tempitem = inv:get_list("selector")
			inv:set_list("sale_memory", tempitem)
		end
		if fields.buy == "Set Buy" then
			local tempitem = inv:get_list("selector")
			inv:set_list("buy_memory", tempitem)
		end
		if fields.stock == "Stock Machine" then
			local form = "size[14,10;]"..
			"list[nodemeta:"..fields.posx..","..fields.posy..","..fields.posz..";main;0,0;14,5;]"..
			"button[5,5;4,1;ret;Return]"..
			"bgcolor[#ff8010b0;false]"..
			"field[0,0;0,0;posx;;"..fields.posx.."]"..
			"field[0,0;0,0;posy;;"..fields.posy.."]"..
			"field[0,0;0,0;posz;;"..fields.posz.."]"..
			"list[current_player;main;3,6;8,4;]"
			minetest.show_formspec(player:get_player_name(), "Trade Machine", form)
		end
		if fields.ret == "Return" then
			local form = "size[13,10;]"..
			"list[nodemeta:"..fields.posx..","..fields.posy..","..fields.posz..";selector;0.5,6.5;3,3;]"..
			"button[1,5;3,1;sell;Set Sell]"..
			"button[9,5;3,1;buy;Set Buy]"..
			"button[5,4;3,2;stock;Stock Machine]"..
			"list[nodemeta:"..fields.posx..","..fields.posy..","..fields.posz..";sale_memory;1,2;3,3;]"..
			"list[nodemeta:"..fields.posx..","..fields.posy..","..fields.posz..";buy_memory;9,2;3,3;]"..
			"image[1,1;3,1;selling.png]"..
			"image[9,1;3,1;buying.png]"..
			"image[3,0;7,1;trademachinetitle.png]"..
			"bgcolor[#ff8010b0;false]"..
			"field[0,0;0,0;posx;;"..fields.posx.."]"..
			"field[0,0;0,0;posy;;"..fields.posy.."]"..
			"field[0,0;0,0;posz;;"..fields.posz.."]"..
			"list[current_player;main;4.5,6;8,4;]"
			minetest.show_formspec(player:get_player_name(), "Trade Machine", form)
		end
		if fields.purchase == "Trade" then
			local pinv = player:get_inventory()
			local buy_stack = inv:get_stack("buy_memory",0)
			local sell_stack = inv:get_stack("sale_memory",0)
			local i = 1
			while i < 9 do
				buy_stack:add_item(inv:get_stack("buy_memory",i))
				sell_stack:add_item(inv:get_stack("sale_memory",i))
				i = i + 1
				print(sell_stack:to_string())
			end
			if inv:room_for_item("main", buy_stack) then
			if pinv:room_for_item("main", sell_stack) then
			if inv:contains_item("main", sell_stack) then
			if pinv:contains_item("main",buy_stack) then
				inv:remove_item("main",sell_stack)
				pinv:remove_item("main",buy_stack)
				inv:add_item("main",buy_stack)
				pinv:add_item("main",sell_stack)
				print(sell_stack:to_string())
				print(buy_stack:to_string())
			end
			end
			end
			end
		end
	end
end)

local function trademachine_allow_metadata_inventory_move(pos, from_list, from_index, to_list, to_index, count, player)
	local meta = minetest.env:get_meta(pos)
	if meta:get_string("owner") == player:get_player_name() and (from_list == "selector" or from_list == "main") then
		return count
	end
	return 0
end

local function trademachine_allow_metadata_inventory_take(pos, listname, index, stack, player)
	local meta = minetest.env:get_meta(pos)
	if meta:get_string("owner") == player:get_player_name() and (listname == "selector" or listname == "main") then
		return stack:get_count()
	end
	return 0
end

local function trademachine_allow_metadata_inventory_put(pos, listname, index, stack, player)
	local meta = minetest.env:get_meta(pos)
	if meta:get_string("owner") == player:get_player_name() and (listname == "selector" or listname == "main") then
		return stack:get_count()
	end
	return 0
end
	
minetest.register_node("trademachine:trademachine", {
	description = "Trade Machine",
	tiles = {"top.png", "bottom.png", "side.png", "side.png", "side.png", "front.png"},
	groups = {melty=3, oddly_breakable_by_hand=2},
	paramtype2 = "facedir",
	after_place_node = trademachine_after_place_node,
	on_rightclick = trademachine_on_rightclick,
	on_player_receive_fields = trademachine_on_receive_fields,
	allow_metadata_inventory_move = trademachine_allow_metadata_inventory_move,
	allow_metadata_inventory_put = trademachine_allow_metadata_inventory_put,
	allow_metadata_inventory_take = trademachine_allow_metadata_inventory_take,
})

