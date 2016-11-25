require "trello"

class SitesController < ApplicationController
  def create
    @site = Site.create_with(site_params).find_or_create_by(board_url: site_params["board_url"])
    find_board(@site.board_id)
    # current_user.trello_client.create(:webhooks, callback_url: "#{ENV['WEBHOOK_URL']}/webhooks/new", id_model: @site.board_id)
    begin
    res = current_user.trello_client.post("/webhooks",
      idModel: @board.id,
      callbackURL: "#{ENV['WEBHOOK_URL']}/webhooks/new"
    )
    rescue
    end
    redirect_to site_path(@site)
  end

  def show
    @site = Site.find_by_name(params[:id])
    Site::URL_REGEX =~ @site.board_url
    find_board($1)
    render :show
  end

  def page
    site = Site.find_by_name(params[:id])
    find_board(site.board_id)
    @html = Rails.cache.fetch("#{site.board_id}/#{params[:list]}") do
      puts "************************** CACHING UNDER: #{site.board_id}/#{params[:list]}"
      @list = @board.lists.detect { |x| x.name.parameterize == params[:list] }
      raise ActionController::RoutingError.new("Not Found") unless @list
      @md_renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new)
      render_to_string
    end
    render html: @html
  end

  private

  def site_params
    params.require(:site).permit(:board_url)
  end

  def find_board(board_id)
    @board = current_user.trello_client.find(:boards, board_id)
  end
end
