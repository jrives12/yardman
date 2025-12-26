require_relative 'yardman'
require_relative 'info'
require_relative 'zone'

API_KEY = ENV['API_KEY']
HEIGHT = 20
WIDTH = 60

def page_zone
  zones = get_zones(API_KEY)
  loop do
    menu_items = zones.each_with_index.map { |zone, index| "#{index + 1} \"#{zone["name"]}\"" }.join(' ')
    
    choice = ""

    system("dialog --menu 'Select' 0 0 0 \
       #{menu_items} \
       #{zones.length + 1} \"return to main menu\" \
       2> /tmp/dialog.out")
    return if $?.exitstatus != 0

    choice = File.read("/tmp/dialog.out").strip.to_i

    break if choice == zones.length + 1
    page_zone_info(zones[choice-1])
  end
  page_main
end

def page_zone_info(zone)
  choice = ""
  system(
    "dialog --menu '#{zone["name"]} Info:
    
     Last Watered: 12:30 pm today
     Moisture Level: 20%

     Select an Option' 0 0 0 \
     1 'water now' \
     2 'return to zone menu' \
     2> /tmp/dialog.out"
  )

  return if $?.exitstatus != 0

  choice = File.read("/tmp/dialog.out").strip.to_i
  case choice
  when 1
    start_zone(API_KEY, zone["id"])
  when 2
    return
  end
end

def page_main
  choice = ""

  system(
    "dialog --menu 'Welcome to Yardman' #{HEIGHT} #{WIDTH} 3 \
     1 'zone menu' \
     2 'AI overview' \
     3 'reboot PI' \
     2> /tmp/dialog.out"
  )

  return if $?.exitstatus != 0

  choice = File.read("/tmp/dialog.out").strip

  case choice
  when "1"
    page_zone
  when "2"
    # gemini
  when "3"
    system("sudo reboot")
  end
end

page_main
