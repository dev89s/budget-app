require 'rails_helper'

RSpec.describe 'purchases/show', type: :view do
  before(:each) do
    assign(:purchase, Purchase.create!(
                        name: 'Name',
                        amount: '9.99',
                        author_id: ''
                      ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(//)
  end
end
