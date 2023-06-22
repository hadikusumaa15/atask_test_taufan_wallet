require 'rails_helper'

RSpec.describe Stock, type: :model do
  it 'saves valid attributes' do
    stock = Stock.new(name: 'my_stock')
    expect(stock).to be_valid
  end
end
