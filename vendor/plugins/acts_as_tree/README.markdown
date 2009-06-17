# acts\_as\_tree #

Specify this `acts_as` extension if you want to model a tree structure by providing parent and children associations


## Installation ##

	gem install shuber-acts_as_tree --source http://gems.github.com
	OR
	script/plugin install git://github.com/shuber/acts_as_tree.git


## Usage ##

Requires a `:foreign_key` option which defaults to `:parent_id`

	class Category < ActiveRecord::Base
	  # schema
	  #   id,        integer
	  #   parent_id, integer
	  #   name,      string
	  
	  acts_as_tree
	end

Also accepts `:order` and `:counter_cache` (defaults to `false`) options


## Example ##

	root
	  \_ child1
	    \_ subchild1
	    \_ subchild2
	
	root      = Category.create(:name => 'root')
	child1    = root.children.create(:name => 'child1')
	subchild1 = child1.children.create(:name => 'subchild1')
	
	root.parent   # nil
	child1.parent # root
	root.children # [child1]
	root.children.first.children.first # subchild1

Copyright (c) 2007 David Heinemeier Hansson, released under the MIT license