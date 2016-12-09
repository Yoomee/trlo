class PageBuilder
  def initialize(site, list_name)
    @site = site
    @list_name = list_name
  end

  def build
    board = @site.user.trello_client.find(:boards, @site.board_id)
    Rails.cache.fetch("#{@site.board_id}/#{@list_name}") do
      list = board.lists.detect { |x| x.name.parameterize == @list_name }
      raise ActionController::RoutingError.new("Not Found") unless list
      md_renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new)
      SitesController.render :page, assigns: { list: list, md_renderer: md_renderer }
    end
  end
end
