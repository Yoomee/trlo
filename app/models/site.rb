class Site < ApplicationRecord
  URL_REGEX = %r(https:\/\/trello.com\/b\/(\S+)\/(\S+))
  THEMES = [
             Theme.new(id: "forestry", name: "Forestry", color: "#3D9970"),
             Theme.new(id: "lemonade", name: "Lemonade stand", color: "#FFDC00"),
             Theme.new(id: "captain", name: "Aye aye captain", color: "#001F3F")
           ].freeze
  validates :board_url, :board_id, :name, presence: true, uniqueness: true
  belongs_to :user

  before_validation :parse_url

  def to_param
    name
  end

  private

  def parse_url
    Site::URL_REGEX =~ board_url
    self.board_id = $1
    self.name = $2
  end
end
