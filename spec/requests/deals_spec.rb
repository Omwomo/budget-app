require 'rails_helper'

RSpec.describe 'Deals', type: :request do
  include Devise::Test::IntegrationHelpers

  before do
    @user = User.create!(name: 'John', email: 'john@example.com', password: 'password')
    @group = Group.create!(name: 'Test Group', user: @user, icon: 'valid_icon.png')
    sign_in @user
  end

  describe 'GET /deals/new' do
    it 'returns http success' do
      get "/groups/#{@group.id}/deals/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /deals' do
    it 'creates a new deal' do
      valid_params = { deal: { name: 'Test Deal', amount: 100, user_id: @user.id, group_id: @group.id } }

      expect do
        post "/groups/#{@group.id}/deals", params: valid_params
      end.to change(Deal, :count).by(1)

      expect(response).to redirect_to(group_path(@group))
      expect(flash[:notice]).to eq('Transaction was successfully created.')
    end

    it 'does not create a deal with invalid params' do
      invalid_params = { deal: { name: '', amount: nil, user_id: @user.id, group_id: @group.id } }

      expect do
        post "/groups/#{@group.id}/deals", params: invalid_params
      end.to_not change(Deal, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
