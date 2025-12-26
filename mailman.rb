## Script to Run. Sends data from apollo to rachio

require_relative 'yardman'

API_KEY = ENV['API_KEY']

flex = get_flex_schedule(API_KEY)
if flex.length == 1
  zones = flex[0]['zones']
else
  puts "multiple flex schedules"
end

loop do
  zones.each do |zone|
    set_zone_moisture_percent(API_KEY, zone['zoneId'], 0.42)
  end
  sleep(3600)
end
