minetest.register_node("tutorial:limited_torch", {
  description = "Limited Torch",
  drawtype = "torchlike",
  --tiles = {"default_torch_on_floor.png", "default_torch_on_ceiling.png", "default_torch.png"},
  tiles = {
    {name="default_torch_on_floor_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
    {name="default_torch_on_ceiling_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
    {name="default_torch_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}}
  },
  inventory_image = "default_torch_on_floor.png",
  wield_image = "default_torch_on_floor.png",
  paramtype = "light",
  paramtype2 = "wallmounted",
  sunlight_propagates = true,
  is_ground_content = false,
  walkable = false,
  light_source = 12,
  selection_box = {
    type = "wallmounted",
    wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
    wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
    wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
  },
  groups = {choppy=2,dig_immediate=3,flammable=1,attached_node=1,hot=2},
  legacy_wallmounted = true,
  after_place_node = function(pos)
    meta = minetest.env:get_meta(pos)
    meta:set_int("duration_remaining",120)
  end
  })
  
minetest.register_craft({
  output = 'tutorial:limited_torch',
  recipe = {
    {'default:coal'},
    {'default:wood'}
  }
})
  
minetest.register_abm({
  nodenames = {"tutorial:limited_torch"},
  interval = 1,
  chance = 1,
  action = function(pos)
    local meta = minetest.env:get_meta(pos)
    if meta:get_int("duration_remaining") <= 0
    then minetest.env:remove_node(pos)
    else meta:set_int("duration_remaining", meta:get_int("duration_remaining") - 1)
    end
  end
})