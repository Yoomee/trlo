require "trello"

class WebhooksController < ApplicationController
  protect_from_forgery except: [:new]
  def verify
    render plain: :ok
  end

  def new
    webhook_data = params["webhook"]["action"]["data"]
    Rails.cache.delete("#{webhook_data['board']['shortLink']}/#{webhook_data['list']['name'].parameterize}")
    @site = Site.find_by_name(webhook_data["board"]["name"].parameterize)
    PageBuilder.new(@site, params[:list]).build
  end

  private

  def find_board(board_id)
    @board = @site.user.trello_client.find(:boards, board_id)
  end
end
