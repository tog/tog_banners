class BannersController < ApplicationController

  def click
    @banner = Banner.active.find(params[:id])
    if @banner
      @banner.click!(current_user, request)
      redirect_to @banner.url
    else
      flash[:error] = I18n.t("tog_banners.public.banners.not_found")
      redirect_to root_path
    end
  end

end