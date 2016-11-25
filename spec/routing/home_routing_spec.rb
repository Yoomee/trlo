require "rails_helper"

RSpec.describe "routes for Home", type: :routing do
  it "routes GET / to the home controller index action" do
    expect(get: "/").to route_to(controller: "home", action: "index")
  end
end
