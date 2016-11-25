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
    find_board(@site.board_id)
    @list = @board.lists.detect { |x| x.name == webhook_data["list"]["name"] }
    raise ActionController::RoutingError.new("Not Found") unless @list
    @md_renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new)
    Rails.cache.write("#{webhook_data['board']['shortLink']}/#{webhook_data['list']['name'].parameterize}", render_to_string("sites/page"))
  end

  private

  def find_board(board_id)
    @board = @site.user.trello_client.find(:boards, board_id)
  end
end
