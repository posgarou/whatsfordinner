require_relative 'spec_helper'

describe 'The front page', type: :feature, js: true do

  it 'loads the test page successfully' do
    visit '/'
    expect(page).to have_content 'Hi there'
  end

  it 'loads the example instructions successfully' do
    visit '/#instructions'
    expect(page).to have_content 'HUEVOS RANCHEROS'
  end
end