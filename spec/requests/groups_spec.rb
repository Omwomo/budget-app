require 'rails_helper'

RSpec.describe 'Groups', type: :request do
  include Devise::Test::IntegrationHelpers

  before do
    @user = User.create!(name: 'John', email: 'john@example.com', password: 'password')
    sign_in @user
  end

  describe 'GET /groups' do
    it 'returns http success' do
      get '/groups'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /groups/:id' do
    let(:group) { Group.create!(name: 'Test Group', icon: 'icon.png', user: @user) }

    it 'returns http success' do
      get "/groups/#{group.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /groups/new' do
    it 'returns http success' do
      get '/groups/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /groups' do
    it 'creates a new group' do
      valid_params = { group: { name: 'New Group Name', icon: 'icon.png', created_at: Time.now } }

      expect do
        post '/groups', params: valid_params
      end.to change(Group, :count).by(1)

      expect(response).to redirect_to('/groups')
      expect(flash[:notice]).to eq('Category was successfully created.')
    end
  end
end
