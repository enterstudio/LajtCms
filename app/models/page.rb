# == Schema Information
# Schema version: 20090301194445
#
# Table name: pages
#
#  id         :integer(4)      not null, primary key
#  title      :string(255)
#  slug       :string(255)
#  content_en :text
#  content_de :text
#  parent_id  :integer(4)
#  position   :integer(4)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Page < ActiveRecord::Base
  has_one :asset

  validates_presence_of :slug
  validates_uniqueness_of :slug, :scope => 'parent_id'
  AppConfig.languages.each do |language, lang|
    validates_presence_of :"title_#{lang}"
    validates_uniqueness_of :"title_#{lang}", :scope => 'parent_id', :message => "A page with this #{language} title already exists."
  end

  before_validation :update_or_create_slug

  acts_as_tree :order => 'position'

  named_scope :all_except, lambda { |id| { :conditions => ['id != ?', id] } }

  class << self
    def max_position(parent_id)
      Page.maximum(:position, :conditions => { :parent_id => parent_id }) || 0
    end

    def title_with_default_lang
      :"title_#{AppConfig.languages.values.first}"
    end
  end

  def path(include_leading_slash = true)
    path = include_leading_slash ? '/' : ''
    path += parent.nil? || parent == Page.root ? slug : [parent.path(false), slug].join('/')
  end

  def path_array
    path(false).split('/')
  end

  def title(lang = AppConfig.languages.values.first, concat_parent_page_titles = false)
    localized_title = self.attributes["title_#{lang}"]
    if concat_parent_page_titles && parent && parent != Page.root
      [parent.title(lang, true), localized_title].join(' | ')
    else
      localized_title
    end
  end

  private

    def update_or_create_slug
      self.slug ||= self.title.try(:slugify)
    end
end
