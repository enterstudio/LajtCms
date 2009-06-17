RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem 'thoughtbot-paperclip', :lib => 'paperclip', :source => 'http://gems.github.com'
  config.gem 'rtomayko-rdiscount', :lib => 'rdiscount', :source => 'http://gems.github.com'
  config.gem 'haml'
  config.gem 'mislav-will_paginate', :lib => 'will_paginate', :source => 'http://gems.github.com'

  config.time_zone = 'UTC'
end

ActionView::Base.field_error_proc = Proc.new { |html_tag, instance| %(<span class="fieldWithErrors">#{html_tag}</span>) }



require 'radius'
