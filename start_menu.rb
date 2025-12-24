require_relative 'yardman'
require_relative 'info'


choice = `dialog --menu "Select" 0 0 0 1 "Option 1" 2 "Option 2" 3 "Exit" 2>&1 </dev/tty >/dev/tty`.strip

case choice
when "1"
  system("ruby ~/myscript.rb")
when "2"
  system("echo 'Option 2 selected'; read -p 'Press Enter'")
when "3",""
  exit
end

