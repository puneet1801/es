# require 'elasticsearch/model'
class Campaign < ApplicationRecord
	# include Elasticsearch::Model
  #  include Elasticsearch::Model::Callbacks
 	# include Searchable
 	# searchkick
   searchkick callbacks: :queue
 	has_many :lists

	CampaignType = %w(camp_a camp_b camp_c camp_d camp_e camp_f camp_g camp_h camp_i camp_j camp_k camp_l camp_m camp_n camp_o camp_p camp_q camp_r camp_s camp_t camp_u camp_v camp_w camp_x camp_y camp_z)

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
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    first_name=[];
    last_name=[];
    email=[];
    phone=[];
    fax=[];
    domain_name=[];

    # lists.map do |l| 
    #   l.contacts.limit(2000).find_in_batches do |group|
    #     group.each {|c| email << c.email; puts "hi" }
    #   end
    # end
    #Contact.limit(500).find_in_batches(batch_size: 100){|g| g.each{|c| email << c.email}}
    # puts self.name
    # lists.map do |l| 
    #   puts "asas"
    #   puts l.name
    #   l.contacts.find_in_batches(batch_size: 100) do |g| 
    #     puts "test"; 
    #     email << g.map(&:email)
    #     #g.each do |c| 
    #     #  email << c.email; 
    #       #first_name << c.first_name; 
    #       #last_name<<c.last_name;
    #       #phone<<c.phone;
    #       #fax<<c.fax;
    #       #domain_name<<c.domain_name 
    #     #end
    #   end
    # end

    puts "==============="
    # puts email

    attrs = attributes.dup 
    relational = { 
      list_name: lists.map(&:name), 
      list_type: lists.map(&:list_type), 
      # contact_email: email.flatten.uniq.compact
      # contact_first_name: lists.map{|l| l.contacts.pluck(:first_name)}.flatten,
      # contact_last_name: lists.map{|l| l.contacts.pluck(:last_name)}.flatten,
      contact_email: lists.map{|l| l.contacts.pluck(:email)}.flatten,
      # contact_phone: lists.map{|l| l.contacts.pluck(:phone)}.flatten,
      # contact_fax: lists.map{|l| l.contacts.pluck(:fax)}.flatten,
      # contact_domain_name: lists.map{|l| l.contacts.pluck(:domain_name)}.flatten
    } 
    puts ":>>>>>>>>>>>>"
    # puts relational
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
