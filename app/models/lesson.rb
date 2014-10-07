class Lesson
    include MongoMapper::EmbeddedDocument

	key :name, String
	key :teacher, String
	key :day, Integer
	key :start, String
	key :end, String

    embedded_in :group
end
