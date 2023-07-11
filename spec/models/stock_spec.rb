require 'rails_helper'

RSpec.describe Stock, type: :model do
  it 'saves valid attributes' do
    stock = Stock.new(indices: 'my_indices', identifier: 'my_stock', user: create(:user))
    expect(stock).to be_valid
  end
end
