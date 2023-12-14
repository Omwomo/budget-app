require 'rails_helper'

RSpec.describe 'Deals new view', type: :feature do
  include Devise::Test::IntegrationHelpers

  before do
    @user = User.create!(name: 'John', email: 'john@example.com', password: 'password')
    @group = Group.create!(name: 'Test Group', user: @user, icon: 'icon_name')
    sign_in @user
    visit new_group_deal_path(@group)
  end

  it 'renders the form for creating a new transaction' do
    expect(page).to have_field('deal_name')
    expect(page).to have_field('deal_amount')
    expect(page).to have_button('create transaction')
  end

  it 'displays transaction errors if any' do
    # Trigger validation errors
    click_button 'create transaction'

    expect(page).to have_content('3 errors prohibited this transaction from being saved:')
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Amount can't be blank")
    expect(page).to have_content('Amount is not a number')
  end
end
