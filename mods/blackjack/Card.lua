-- Implementation of a basic Card class. Each card has a suit, and value.

local Card = {}
Card.__index = Card

function Card.new(value, suit) 
	local self = setmetatable({}, Card)
	self.value = value
	self.suit = suit
	return self
end

function Card.set_value(self, newVal)
	self.value = newVal
end

function Card.set_suit(self, newSuit)
	self.suit = newSuit
end

function Card.get_value(self)
	return self.value
end

function Card.get_suit(self)
	return self.suit
end


local i = Card.new(5)

print(i:get_value())
i:set_value(6)
print(i:get_value())