class User < ApplicationRecord
  validates :uid,
            :name,
            :token,
            :secret,
            presence: true

  def trello_client
    @trello_client ||= Trello::Client.new(
      consumer_key: ENV["TRELLO_KEY"],
      consumer_secret: ENV["TRELLO_SECRET"],
      oauth_token: token,
      oauth_token_secret: nil
    )
  end

  def self.find_or_create_from_auth_hash(hash)
    User.find_by(uid: hash["uid"]) || User._create_from_auth_hash(hash)
  end

  def self._create_from_auth_hash(hash)
    User.create!(
      uid: hash["uid"],
      name: hash["info"]["name"],
      token: hash["credentials"]["token"],
      secret: hash["credentials"]["secret"]
    )
  end
end
