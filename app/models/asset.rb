# == Schema Information
# Schema version: 20090301194445
#
# Table name: assets
#
#  id                      :integer(4)      not null, primary key
#  title                   :string(255)
#  asset_file_file_name    :string(255)
#  asset_file_content_type :string(255)
#  asset_file_file_size    :integer(4)
#  asset_file_updated_at   :datetime
#  page_id                 :integer(4)
#  created_at              :datetime
#  updated_at              :datetime
#

class Asset < ActiveRecord::Base
  belongs_to :page
  has_attached_file :asset_file, :styles => AppConfig.image_sizes.dup.symbolize_keys!
  validates_presence_of :title, :asset_file_file_name
end
