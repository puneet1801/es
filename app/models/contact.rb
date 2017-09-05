class Contact < ApplicationRecord
	# include Searchable
	belongs_to :list

	after_commit :refresh_campaign_index
	# settings index: { number_of_shards: 1 } do
 #    mappings(_parent: {type: 'campaigns'}) do
 #      indexes :name, analyzer: 'english', type: 'string'
 #      indexes :email, analyzer: 'english', type: 'string'
 #    end
 #  end

 #  def parent
 #  	list_id
 #  end

	def refresh_campaign_index
		self.try(:list).try(:campaign).try(:reindex)
	end
end
