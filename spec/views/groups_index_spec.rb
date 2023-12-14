require 'rails_helper'

RSpec.describe 'Groups Index View', type: :feature do
  include Devise::Test::IntegrationHelpers

  before do
    @user = User.create!(name: 'test', email: 'test@example.com', password: 'password')
    sign_in @user
    visit groups_path
  end

  it 'displays the categories' do
    expect(page).to have_selector('.category-page')
    expect(page).to have_selector('.nav-area')
    expect(page).to have_selector('h1', text: 'CATEGORIES')

    within('.categories') do
      expect(page).to have_selector('.category', count: Group.count)
    end

    expect(page).to have_selector('.add-category')
    expect(page).to have_selector('.new-category-btn')
    expect(page).to have_link('ADD CATEGORY', href: new_group_path)
  end

  it 'displays the category details' do
    @groups = Group.all
    @groups.each do |group|
      within("#groups ##{dom_id(group)}") do
        expect(page).to have_selector('.icon')
        expect(page).to have_selector('.name')
        expect(page).to have_selector('.created')
        expect(page).to have_selector('.total')
      end
    end
  end

  it 'displays logout if user is signed in' do
    expect(page).to have_selector('.nav-area')
    expect(page).to have_button('Logout')
  end

  it 'does not display logout if user is not signed in' do
    sign_out @user
    visit groups_path
    expect(page).to_not have_button('Logout')
  end
end
