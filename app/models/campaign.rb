# require 'elasticsearch/model'
class Campaign < ApplicationRecord
	# include Elasticsearch::Model
  #  include Elasticsearch::Model::Callbacks
 	include Searchable
 	has_many :lists

	CampaignType = %w(camp_a camp_b camp_c camp_d camp_e camp_f camp_g camp_h camp_i camp_j)

	paginates_per 10

	 # def self.search(query)
  #   __elasticsearch__.search(
  #     {
  #       query: {
  #         multi_match: {
  #           query: query,
  #           fields: ['name', 'campaign_type']
  #         }
  #       },
  #       highlight: {
  #         pre_tags: ['<mark>'],
  #         post_tags: ['</mark>'],
  #         fields: {
  #           name: {},
  #           campaign_type: {}
  #         }
  #       }
  #     }
  #   )
  # end

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :name, analyzer: 'english', type: 'string'
      indexes :campaign_type, analyzer: 'english', type: 'string'

      indexes :lists, type: 'nested' do
      	indexes :id, type: 'integer'
      	indexes :name, analyzer: 'english', type: 'string'
      	indexes :list_type, analyzer: 'english', type: 'string'
      end
    end
  end
end
