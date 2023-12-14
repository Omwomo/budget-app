require 'rails_helper'

RSpec.describe 'Groups New View', type: :feature do
  include Devise::Test::IntegrationHelpers

  before do
    @user = User.create!(name: 'test', email: 'test@example.com', password: 'password')
    sign_in @user
    visit new_group_path
  end

  it 'renders the form for creating a new group' do
    expect(page).to have_selector('h2', text: 'Add New Category')
    expect(page).to have_selector('form[action="/groups"]')
    expect(page).to have_selector('form input[type="text"][name="group[name]"]')
    expect(page).to have_field('group_icon')
    expect(page).to have_selector('form input[type="submit"][value="Create Group"]')
  end

  it 'displays a link to go back to groups index' do
    expect(page).to have_link(href: groups_path)
  end
end
