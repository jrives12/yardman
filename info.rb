require_relative 'yardman'

def get_zone(api_key)
  url = URI("https://api.rach.io/1/public/person/#{get_person(api_key)}")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request["accept"] = 'application/json'
  request["Authorization"] = "Bearer #{api_key}"

  response = http.request(request)
  person_info = JSON.load(response.body)

  person_info["devices"][0]["zones"].sort_by { |zone| zone["zoneNumber"] }
end

def get_person(api_key)
  url = URI("https://api.rach.io/1/public/person/info")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request["accept"] = 'application/json'
  request["Authorization"] = "Bearer #{api_key}"

  response = http.request(request)
  JSON.load(response.body)['id']
end
