class Faculty 
	include MongoMapper::Document

	key :name, String
	key :number, Integer

	many :groups, :dependent => :destroy
end
