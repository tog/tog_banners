class Admin::BannerZonesController < Admin::BaseController
  
  before_filter :find_zone, :except => [:index, :new, :create]
  
  def index
    @order = params[:order] || 'name'
    @page = params[:page] || '1'
    @asc = params[:asc] || 'asc'
    @banner_zones = BannerZone.paginate :per_page => 10,
                                 :page => @page,
                                 :order => @order + " " + @asc
  end
  
  def show
    @order = params[:order] || 'name'
    @page = params[:page] || '1'
    @asc = params[:asc] || 'asc'    
    @banners = @banner_zone.banners.paginate :per_page => 10,
                                             :page => @page,
                                             :order => @order + " " + @asc    
  end 

  def new
    @banner_zone = BannerZone.new
  end

  def edit
  end
  
  def create
    @banner_zone = BannerZone.new(params[:banner_zone])
    @banner_zone.save!
    redirect_to(admin_banner_zone_url(@banner_zone))
    flash[:ok] = I18n.t("tog_banners.admin.zones.created")
  rescue ActiveRecord::RecordInvalid
    flash[:error] = I18n.t("tog_banners.admin.zones.creation_order")
    render :action => 'new'
  end

  def update
    @banner_zone.update_attributes!(params[:banner_zone])
    redirect_to(admin_banner_zone_url(@banner_zone))
    flash[:ok] = I18n.t("tog_banners.admin.zones.updated")    
  rescue ActiveRecord::RecordInvalid
    flash[:error] = I18n.t("tog_banners.admin.zones.update_error")
    render :action => 'edit'
  end
  
  def destroy
    @banner_zone.destroy
    flash[:ok]= I18n.t("tog_banners.admin.zones.deleted")
    redirect_to admin_banner_zones_url
  end
  
  protected

    def find_zone
      @banner_zone = BannerZone.find(params[:id]) rescue nil
      if @banner_zone.nil?
        flash[:error] = I18n.t("tog_banners.admin.zones.not_found")
        redirect_to admin_banner_zones_path
      end
    end
end
