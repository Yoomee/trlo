require "trello"

class SitesController < ApplicationController
  def create
    @site = current_user.sites.create_with(site_params).find_or_create_by(board_url: site_params["board_url"])
    find_board(@site.board_id)
    begin
      current_user.trello_client.post(
        "/webhooks",
        idModel: @board.id,
        callbackURL: "#{ENV['WEBHOOK_URL']}/webhooks/new"
      )
    rescue
    end
    redirect_to theme_site_path(@site), subdomain: [@site.name, Rails.application.config.subdomain].compact.join(".")
  end

  def theme
    @site = Site.find_by_name(params[:id])
  end

  def set_theme
    @site = Site.find_by_name(params[:id])
    @site.update_attributes(theme: params[:site][:theme])
    redirect_to subdomain: [@site.name, Rails.application.config.subdomain].compact.join("."), controller: "home", action: "index"
  end

  def show
    find_site
    Site::URL_REGEX =~ @site.board_url
    find_board($1)
    render :show, layout: "site"
  end

  def page
    find_site
    render html: PageBuilder.new(@site, params[:list]).build
  end

  private

  def site_params
    params.require(:site).permit(:board_url)
  end

  def find_site
    @site = Site.find_by_name(request.subdomains(0))
  end

  def find_board(board_id)
    @board = @site.user.trello_client.find(:boards, board_id)
  end
end
