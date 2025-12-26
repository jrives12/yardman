require 'uri'
require 'net/http'

def start_zone(api_key, zone_id)
  url = URI("https://api.rach.io/1/public/zone/start")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true

  request = Net::HTTP::Put.new(url)
  request["accept"] = 'application/json'
  request["content-type"] = 'application/json'
  request["Authorization"] = "Bearer #{API_KEY}"
  request.body = "{\"id\":\"#{zone_id}\",\"duration\":300}"

  response = http.request(request)
  puts response.read_body
end

def set_zone_moisture_percent(api_key, zone_id, percent)
  url = URI("https://api.rach.io/1/public/zone/setMoisturePercent")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true

  request = Net::HTTP::Put.new(url)
  request["accept"] = 'application/json'
  request["content-type"] = 'application/json'
  request["Authorization"] = "Bearer #{API_KEY}"
  request.body = "{\"id\":\"#{zone_id}\",\"percent\":#{percent}}"

  response = http.request(request)
  puts response.code
end
