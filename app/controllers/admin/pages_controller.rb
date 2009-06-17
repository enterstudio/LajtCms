class Admin::PagesController < AdminController
  def index
    redirect_to admin_pages_path and return unless request.request_uri.include?('pages')
    @root_page = Page.root
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(params[:page])
    @page.position = Page.max_position(@page.parent_id) + 1
    if @page.save
      flash[:notice] = 'Utworzono stronę.'
      redirect_to params[:create_and_stay].nil? ? admin_pages_path : edit_admin_page_path(@page)
    else
      render :action => 'new'
    end
  end

  def edit
    @page = Page.find(params[:id])
    @prev_page = if @page.position > 1
      Page.find_by_parent_id_and_position(@page.parent_id, @page.position - 1)
    else
      @page.parent
    end
    @next_page = if !@page.children.empty?
      @page.children.first
    elsif @page.siblings.empty? || @page.siblings.map(&:position).max < @page.position
      Page.find_by_parent_id_and_position(@page.parent.parent_id, @page.parent.position + 1)
    else
      Page.find_by_parent_id_and_position(@page.parent_id, @page.position + 1)
    end
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      flash[:notice] = 'Zaktualizowano stronę.'
      redirect_to params[:save_and_stay].nil? ? admin_pages_path : edit_admin_page_path(@page)
    else
      render :action => 'edit'
    end
  end

  def destroy
    @page = Page.find(params[:id])
    Page.transaction do
      @page.destroy
      next_pages = Page.scoped_by_parent_id(@page.parent_id).all(:conditions => ['position > ?', @page.position])
      next_pages.each do |page|
        page.position -= 1
        page.save!
      end
    end
    flash[:notice] = 'Skasowano materiał ze strony.'
    redirect_to admin_pages_path
  end

  def move_down
    move(:down)
  end

  def move_up
    move(:up)
  end
  
  private
  
    def move(where)
      begin
        Page.transaction do
          @page = Page.find(params[:id])
          @page.position = where == :up ? @page.position - 1 : @page.position + 1
          page_in_new_position = Page.scoped_by_parent_id(@page.parent_id).scoped_by_position(@page.position).first
          page_in_new_position.position = where == :up ? @page.position + 1 : @page.position - 1
          page_in_new_position.save!
          @page.save!
          flash[:notice] = 'Zmieniono pozycje.'
        end
      rescue ActiveRecord::RecordNotSaved => e
        flash[:error] = 'Nie zmieniono pozycjis.'
      end
      redirect_to admin_pages_path
    end
end
