class Admin::AssetsController < AdminController
  before_filter :find_asset, :only => [:show, :edit, :update, :destroy]

  def index
    sort = case params[:sort]
    when /^filename/
      'asset_file_file_name'
    when /^title/
      'title'
    when /^id/
      'id'
    end
    sort += ' DESC' if params[:sort] =~ /_desc$/
    @assets = Asset.paginate(:page => params[:page], :per_page => 10, :order => sort)
  end

  def show
    @image_sizes = AppConfig.image_sizes.sort_by { |k, v| v.split('x').inject(0) { |sum, v| sum += v.to_i } } << ['original', '']
  end

  def new
    @asset = Asset.new
  end

  def create
    @asset = Asset.new(params[:asset])
    if @asset.save
      flash[:notice] = 'Zapisano załącznik.'
      redirect_to assets_path
    else
      render :action => 'new'
    end
  end

  def edit
  end

  def update
    if @asset.update_attributes(params[:asset])
      flash[:notice] = 'Zaktualizowano załącznik.'
      redirect_to assets_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @asset.destroy
    flash[:notice] = 'Skasowano załącznik.'
    redirect_to assets_path
  end

  private

    def find_asset
      @asset = Asset.find(params[:id])
    end
end
