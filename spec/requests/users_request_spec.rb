require 'rails_helper'

RSpec.describe "api/v1/users", type: :request do
  context "available" do
    it 'Returns a status of 200 with no params' do
      get '/api/v1/users/available'
      parsed = JSON.parse(response.body, object_class: OpenStruct)
      expect(response).to have_http_status(200)
      expect(parsed.data).to eq(true)
    end

    it 'Returns false if username already exists' do
      create_user(name: 'testtest')
      get '/api/v1/users/available?username=testtest'
      parsed = JSON.parse(response.body, object_class: OpenStruct)
      expect(response).to have_http_status(200)
      expect(parsed.data).to eq(false)
    end
end

  context "show" do
    it 'Returns a status of 404 if does not exist' do
      get '/api/v1/users/name'
      parsed = JSON.parse(response.body, object_class: OpenStruct)
      expect(response).to have_http_status(404)
    end
  end
end
