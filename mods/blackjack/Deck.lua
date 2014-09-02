-- Deck.lua
-- Written by: Justin Telmo
-- Do you really want to steal this?

local Deck = {}
Deck.__index = Deck

function Deck.new(cards)
	local self = setmetatable({}, Deck)
	self.cards = cards
end

function Deck.get_cards(self)
	return self.cards
end

function Deck.set_cards(self, cards)
	self.cards = cards
end

-- Short implementation of the Fisher-Yates shuffle.
-- Algorithm can be found at
-- http://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle#The_.22inside-out.22_algorithm
function Deck.shuffle() 
	local shuffledCards = self.cards
	for i=0, 51, 1 do
		local j = math.random(0, table.getn(self))
		if j != i then
			shuffledCards[i] = shuffledCards[j
		end
		self.cards[j] = shuffledCards[i]
	end
end
