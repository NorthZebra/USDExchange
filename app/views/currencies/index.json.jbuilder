json.array!(@currencies) do |currency|
  json.extract! currency, :id, :date, :bid, :ask
  json.url currency_url(currency, format: :json)
end
