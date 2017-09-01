json.extract! campaign, :id, :name, :campaign_type, :created_at, :updated_at
json.url campaign_url(campaign, format: :json)
