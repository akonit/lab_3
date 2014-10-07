class Group
    include MongoMapper::EmbeddedDocument

	key :name, String
	key :cource, Integer

    many :lessons, :dependent => :destroy
    embedded_in :faculty
end
