class AdminController < ApplicationController
  before_filter :authenticate
  layout 'admin'
  
  protected
  
    def authenticate
      #return true unless RAILS_ENV == 'production'
      authenticate_or_request_with_http_basic('Admin') do |username, password|
        username == 'admin' && password == 'haslo123'
      end
    end
end
