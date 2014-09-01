local function trademachine_on_rightclick(pos, node, player, itemstack, pointed_thing)
	local meta = minetest.env:get_meta(pos)
	print(pos)
	local form 
	-- Show a text list right now instead.
	form = "textlist[0,0;10,10;items;one,two,three]"
	minetest.show_formspec(player:get_player_name(), "Auction House", form)
end

minetest.register_node("auctionhouse:auctionhouse", {
	description = "Auction House",
	tiles = {"top.png", "bottom.png", "side.png", "side.png", "side.png", "front.png"},
	groups = {melty=3, oddly_breakable_by_hand=2, flammable=1},
	paramtype2 = "facedir",
	after_place_node = trademachine_after_place_node,
	on_rightclick = trademachine_on_rightclick,
	on_player_receive_fields = trademachine_on_receive_fields,
	allow_metadata_inventory_move = trademachine_allow_metadata_inventory_move,
	allow_metadata_inventory_put = trademachine_allow_metadata_inventory_put,
	allow_metadata_inventory_take = trademachine_allow_metadata_inventory_take,
})
