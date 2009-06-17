ActionController::Routing::Routes.draw do |map|
  map.namespace 'admin' do |admin|
    admin.resources :pages, :member => { :move_up => :get, :move_down => :get }
    admin.resources :assets, :name_prefix => nil
    admin.root :controller => 'pages', :action => 'index'
  end

  map.root_with_lang ':lang', :controller => 'pages', :action => 'index', :requirements => { :lang => /#{AppConfig.languages.values.join('|')}/ }
  map.show_page ':lang/*path', :controller => 'pages', :action => 'show', :requirements => { :lang => /#{AppConfig.languages.values.join('|')}/ }
  map.root :controller => 'pages', :action => 'index'
end
