require "rails_helper"

RSpec.describe "Homepage", type: :request do
  it "renders the homepage" do
    get "/"
    expect(response).to render_template(:index)
    expect(response.body).to include("Trlo")
  end
end
