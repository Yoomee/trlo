require "rails_helper"

RSpec.describe "routes for Auth", type: :routing do
  it "routes GET /auth/trello/callback to the auth/trello controller index action" do
    expect(get: "/auth/trello/callback").to route_to(controller: "auth/trello", action: "callback")
  end
end
