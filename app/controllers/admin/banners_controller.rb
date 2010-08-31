class Admin::BannersController < Admin::BaseController
  
  before_filter :find_banner, :except => [:index, :new, :create]

  def index
    @order = params[:order] || 'start_date'
    @page = params[:page] || '1'
    @asc = params[:asc] || 'desc'
    @banners = Banner.paginate :per_page => 10,
                                 :page => @page,
                                 :order => @order + " " + @asc
  end
  
  def show
    @order = params[:order] || 'created_at'
    @page = params[:page] || '1'
    @asc = params[:asc] || 'asc'    
    @clicks = @banner.banner_clicks.paginate :per_page => 25,
                                             :page => @page,
                                             :order => @order + " " + @asc    
  end 

  def new
    @banner = Banner.new(:start_date => Date.today + 1.day, :end_date => Date.today + 1.month)
  end

  def edit
  end
  
  def create
    @banner = Banner.new(params[:banner])
    @banner.save!
    redirect_to(admin_banner_url(@banner))
    flash[:ok] = I18n.t("tog_banners.admin.banners.created")
  rescue ActiveRecord::RecordInvalid
    flash[:error] = I18n.t("tog_banners.admin.banners.creation_order")
    render :action => 'new'
  end

  def update
    @banner.update_attributes!(params[:banner])
    redirect_to(admin_banner_url(@banner))
    flash[:ok] = I18n.t("tog_banners.admin.banners.updated")    
  rescue ActiveRecord::RecordInvalid
    flash[:error] = I18n.t("tog_banners.admin.banners.update_error")
    render :action => 'edit'
  end
  
  def destroy
    @banner.destroy
    flash[:ok]= I18n.t("tog_banners.admin.banners.deleted")
    redirect_to admin_banners_url
  end
  
  protected

    def find_banner
      @banner = Banner.find(params[:id]) rescue nil
      if @banner.nil?
        flash[:error] = I18n.t("tog_banners.admin.banners.not_found")
        redirect_to admin_banners_path
      end
    end
    
end