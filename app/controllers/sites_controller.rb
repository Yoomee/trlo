require "trello"

class SitesController < ApplicationController
  def create
    @site = Site.create_with(site_params).find_or_create_by(board_url: site_params["board_url"])

    redirect_to site_path(@site)
  end

  def show
    @site = Site.find_by_name(params[:id])
    Site::URL_REGEX =~ @site.board_url
    find_board($1)
    render :show
  end

  private

  def site_params
    params.require(:site).permit(:board_url)
  end

  def find_board(board_id)
    @client = Trello::Client.new(
      consumer_key: ENV["TRELLO_KEY"],
      consumer_secret: ENV["TRELLO_SECRET"],
      oauth_token: current_user.token,
      oauth_token_secret: current_user.token
    )
    @board = @client.find(:boards, board_id)
  end
end
