

local blackjackDealer = {}
blackjackDealer.__index = blackjackDealer

function blackjackDealer.new()
	local self = setmetatable({}, blackjackDealer)
	self.player = blackjackDealer.getPlayer()
end

function blackjackDealer.getPlayer() 
	if player:is_player() then
		return player:get_player_name()
	end
end