require_relative 'yardman'
require_relative 'info'

API_KEY = ENV['API_KEY']

zones = get_zones(api_key)

menu_items = zones.each_with_index.map { |zone, index| "#{index + 1} \"#{zone["name"]}\"" }.join(' ')

choice = `dialog --menu "Select" 0 0 0 1 #{menu_items} 2>&1 </dev/tty >/dev/tty`.strip

case choice
when "1"
  system("ruby ~/myscript.rb")
when "2"
  system("echo 'Option 2 selected'; read -p 'Press Enter'")
when "3",""
  exit
end

