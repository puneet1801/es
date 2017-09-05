# require 'elasticsearch/model'
class Campaign < ApplicationRecord
	# include Elasticsearch::Model
  #  include Elasticsearch::Model::Callbacks
 	# include Searchable
 	searchkick
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

  # settings index: { number_of_shards: 1 } do
  #   mappings dynamic: 'false' do
  #     indexes :name, analyzer: 'english', type: 'string'
  #     indexes :campaign_type, analyzer: 'english', type: 'string'

  #     indexes :lists, type: 'nested' do
  #     	indexes :id, type: 'integer'
  #     	indexes :name, analyzer: 'english', type: 'string'
  #     	indexes :list_type, analyzer: 'english', type: 'string'
  #     end
  #   end
  # end
  def search_data 
    # binding.pry
    attrs = attributes.dup 
    relational = { list_name: lists.map(&:name), list_type: lists.map(&:list_type), contact_name: lists.map{|l| l.contacts.pluck(:name)}.flatten } 
    attrs.merge! relational 
  end

  # searchkick mappings: {
  #   campaign: {
  #     properties: {
  #       name: {type: "string"},
  #       campaign_type: {type: "string"},
  #       lists:{
  #         type: 'nested',
  #         properties:{
  #           list_id: {type: 'integer'},
  #           name: {type: 'string'},
  #           list_type: {type: 'string'}
  #         }
  #       }
  #     }
  #   }
  # }

  def self.es_search(query)
    Campaign.search(
      body:{
        query: {
          constant_score: {
            filter:{ 
              bool: {
                should:[
                  {term: { name: query }},
                  {term: { campaign_type: query }},
                  {term: { list_name: query }},
                  {term: { list_type: query }},
                ]
              }
            }  
          }
        }
      }
    )
  end
end
