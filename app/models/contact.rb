class Contact < ApplicationRecord
	include Searchable

	# settings index: { number_of_shards: 1 } do
 #    mappings(_parent: {type: 'campaigns'}) do
 #      indexes :name, analyzer: 'english', type: 'string'
 #      indexes :email, analyzer: 'english', type: 'string'
 #    end
 #  end

 #  def parent
 #  	list_id
 #  end
end
