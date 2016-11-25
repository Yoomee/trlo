class WebhooksController < ApplicationController
  protect_from_forgery except: [:new]
  def verify
    render plain: :ok
  end

  def new
    webhook_data = params["webhook"]["action"]["data"]
    Rails.cache.delete("#{webhook_data['board']['shortLink']}/#{webhook_data['list']['name'].parameterize}")
  end
end
