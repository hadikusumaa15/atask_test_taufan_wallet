require 'rails_helper'
require 'webmock/rspec'

RSpec.describe LatestStockPrice do
  let(:api_host) {'latest-stock-price.p.rapidapi.com'}
  let(:api_key) {'cbddc9ecf7msha8139fd05f39725p13e191jsnb256be01d751'}

  describe '.prices' do
    it 'returns stock prices for the given indices' do
      indices = 'NIFTY 50'
      expected_query = { Indices: indices }.to_param
      expected_url = "https://#{api_host}/price?#{expected_query}"

      stub_request(:get, expected_url)
        .with(headers: { 'X-RapidAPI-Key' => api_key })
        .to_return(status: 200, body: '[{"symbol": "NIFTY 50","identifier": "NIFTY 50","lastPrice": 11400.21}, {"symbol": "NIFTY 100","identifier": "NIFTY 100","lastPrice": 12202.11}]')

      response = LatestStockPrice.prices(indices: indices)

      expect(response).to eq([{"symbol" => "NIFTY 50","identifier" => "NIFTY 50","lastPrice" => 11400.21}, {"symbol" => "NIFTY 100","identifier" => "NIFTY 100","lastPrice" => 12202.11}])
      expect(WebMock).to have_requested(:get, expected_url)
        .with(headers: { 'X-RapidAPI-Key' => api_key })
    end
  end

  describe '.price' do
    it 'returns the stock price for the given index' do
      indices = 'NIFTY ENERGY'
      identifier = 'NIFTY ENERGY'
      expected_query = { Indices: indices, Identifier: identifier }.to_param
      expected_url = "https://#{api_host}/price?#{expected_query}"

      stub_request(:get, expected_url)
        .with(headers: { 'X-RapidAPI-Key' => api_key })
        .to_return(status: 200, body: '[{"symbol": "NIFTY ENERGY","identifier": "NIFTY ENERGY","lastPrice": 25602.35}]')

      response = LatestStockPrice.price(indices: indices, identifier: identifier)

      expect(response).to eq([{"symbol"=>"NIFTY ENERGY","identifier"=>"NIFTY ENERGY","lastPrice"=>25602.35}])
      expect(WebMock).to have_requested(:get, expected_url).with(headers: { 'X-RapidAPI-Key' => api_key })
    end
  end

  describe '.price_all' do
    it 'returns all stock prices' do
      expected_url = "https://#{api_host}/any"

      stub_request(:get, expected_url)
        .with(headers: { 'X-RapidAPI-Key' => api_key })
        .to_return(status: 200, body: '[{ "identifier": "NIFTY 50", "lastPrice": 499 }, { "identifier": "NIFTY NEXT", "lastPrice": 2500.0 }]')

      response = LatestStockPrice.price_all

      expect(response).to eq([{ 'identifier' => 'NIFTY 50', 'lastPrice' => 499 }, { 'identifier' => 'NIFTY NEXT', 'lastPrice' => 2500.0 }])
      expect(WebMock).to have_requested(:get, expected_url)
        .with(headers: { 'X-RapidAPI-Key' => api_key })
    end
  end
end
