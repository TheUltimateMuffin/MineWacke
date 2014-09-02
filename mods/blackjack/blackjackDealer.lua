

local blackjackDealer = {}
blackjackDealer.__index = blackjackDealer

function blackjackDealer.new()
	local self = setmetatable({}, blackjackDealer)
	self.players = blackjackDealer.getPlayers()
end