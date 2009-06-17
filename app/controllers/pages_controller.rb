class PagesController < ApplicationController
  before_filter :find_root_page

  def index
    if @root_page.nil?
      redirect_to admin_pages_path
    else
      redirect_to show_page_path(:path => @root_page.path_array, :lang => params[:lang] || AppConfig.languages.values.first)
    end
  end

  def show
    unless AppConfig.languages.values.include?(params[:lang])
      params[:lang] = AppConfig.languages.values.first
      redirect_to show_page_path(params) and return
    end
    slug = params[:path].last
    pages = Page.find_all_by_slug(slug)
    @page = pages.detect { |p| p.path_array == params[:path] }
    raise ActiveRecord::RecordNotFound.new("Nie znaleziono /#{params[:path].join('/')}") if @page.nil?
  end

  protected

    def find_root_page
      @root_page = Page.root
    end
end
