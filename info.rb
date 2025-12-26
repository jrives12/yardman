require_relative 'yardman'

def get_person(api_key)
  url = URI("https://api.rach.io/1/public/person/#{get_person_id(api_key)}")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request["accept"] = 'application/json'
  request["Authorization"] = "Bearer #{api_key}"

  response = http.request(request)
  person_info = JSON.load(response.body)
end

def get_person_id(api_key)
  if (info = File.read('account_info/person_id')) != ""
    return info
  end
  url = URI("https://api.rach.io/1/public/person/info")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request["accept"] = 'application/json'
  request["Authorization"] = "Bearer #{api_key}"

  response = http.request(request)
  info = JSON.load(response.body)['id']

  file = File.open('account_info/person_id', 'w')
  require 'debug'; debugger
  file.write(info)

  info
end

def get_zones(api_key)
  get_person(api_key)["devices"][0]["zones"].sort_by { |zone| zone["zoneNumber"] }
end

def get_flex_schedule(api_key)
  get_person(api_key)["devices"][0]["flexScheduleRules"]
end
