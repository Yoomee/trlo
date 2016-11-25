class User < ApplicationRecord
  validates :uid,
            :name,
            :token,
            :secret,
            presence: true

  class << self
    def find_or_create_from_auth_hash(hash)
      User.find_by(uid: hash["uid"]) || User.create_from_auth_hash(hash)
    end

    private

    def create_from_auth_hash(hash)
      User.create!(
        uid: hash["uid"],
        name: hash["info"]["name"],
        token: hash["credentials"]["token"],
        secret: hash["credentials"]["secret"]
      )
    end
  end
end
