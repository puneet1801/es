class List < ApplicationRecord
	# include Searchable

	belongs_to :campaign
	has_many :contacts

	after_commit :refresh_campaign_index

	ListType = %w(list_a list_b list_c list_d list_e list_f list_g list_h list_i list_j)

	# index_name 'campaigns'

	# settings index: { number_of_shards: 1 } do
 #    mappings(_parent: {type: 'campaigns'}) do
 #      indexes :name, analyzer: 'english', type: 'string'
 #      indexes :list_type, analyzer: 'english', type: 'string'
 #    end
 #  end

 #  def parent
 #  	campaign_id
 #  end
	def refresh_campaign_index
		self.try(:campaign).try(:reindex)
	end
end
