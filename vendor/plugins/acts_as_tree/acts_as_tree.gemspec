Gem::Specification.new do |s| 
  s.name    = 'acts_as_tree'
  s.version = '1.0.0'
  s.date    = '2009-01-15'
  
  s.summary     = 'Allows you to create tree structures with ActiveRecord'
  s.description = 'Allows you to create tree structures with ActiveRecord'
  
  s.author   = 'Sean Huber'
  s.email    = 'shuber@huberry.com'
  s.homepage = 'http://github.com/shuber/acts_as_tree'
  
  s.has_rdoc = false
  s.rdoc_options = ['--line-numbers', '--inline-source', '--main', 'README.markdown']
  
  s.require_paths = ['lib']
  
  s.files = %w(
    CHANGELOG
    init.rb
    lib/acts_as_tree.rb
    MIT-LICENSE
    Rakefile
    README.markdown
  )
  
  s.test_files = %w(
    test/acts_as_tree_test.rb
  )
end