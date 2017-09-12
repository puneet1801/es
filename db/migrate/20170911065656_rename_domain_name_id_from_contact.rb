class RenameDomainNameIdFromContact < ActiveRecord::Migration[5.1]
  def change
  	rename_column :contacts, :domain_name_id, :domain_name
  end
end
