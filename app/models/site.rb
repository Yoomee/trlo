class Site < ApplicationRecord
  URL_REGEX = %r(https:\/\/trello.com\/b\/(\S+)\/(\S+))
  validates :board_url, :board_id, :name, presence: true, uniqueness: true

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
