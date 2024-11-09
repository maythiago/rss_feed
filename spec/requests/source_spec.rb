require 'rails_helper'

RSpec.describe "Sources", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/source/index"
      expect(response).to have_http_status(:success)
    end
  end

end
