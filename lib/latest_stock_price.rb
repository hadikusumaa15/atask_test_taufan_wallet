module LatestStockPrice
  class << self
    require 'net/http'
    require 'json'
    require 'uri'

    API_HOST = 'latest-stock-price.p.rapidapi.com'
    API_KEY = 'cbddc9ecf7msha8139fd05f39725p13e191jsnb256be01d751'

    def prices(indices:)
      query = {Indices: indices}.to_param
      url = URI("https://#{API_HOST}/price?#{query}")

      http_get(url)
    end

    def price(indices:, identifier:)
      query = {Indices: indices, Identifier: identifier}.to_param
      url = URI("https://#{API_HOST}/price?#{query}")
   
      response = http_get(url)
    end

    def price_all
      url = URI("https://#{API_HOST}/any")

      http_get(url)
    end

    def indices_list
      [
        'ALL',
        'NIFTY 50',
        'NIFTY NEXT 50',
        'NIFTY 100',
        'NIFTY 200',
        'NIFTY 500',
        'NIFTY MIDCAP 50',
        'NIFTY MIDCAP 100',
        'NIFTY MIDCAP 150',
        'NIFTY SMLCAP 50',
        'NIFTY SMLCAP 100',
        'NIFTY SMLCAP 250',
        'NIFTY MIDSML 400',
        'NIFTY BANK',
        'NIFTY AUTO',
        'NIFTY FINSRV25 50',
        'NIFTY FIN SERVICE',
        'NIFTY FMCG',
        'NIFTY IT',
        'NIFTY MEDIA',
        'NIFTY METAL',
        'NIFTY INFRA',
        'NIFTY ENERGY',
        'NIFTY PHARMA',
        'NIFTY PSU BANK',
        'NIFTY PVT BANK'
      ]
    end

    private

    def http_get(url)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["X-RapidAPI-Key"] = API_KEY
      request["X-RapidAPI-Host"] = API_HOST
      response = http.request(request)

      JSON.parse response.read_body
    end
  end
end
