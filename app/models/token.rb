class Token < ApplicationRecord
	
	TYPES = {
		note: "Note",
		debate: "Debate"
	}
	belongs_to :post 
	belongs_to :layer
end
