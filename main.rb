require_relative 'soda_client'
require_relative 'food_truck'

OFFSET_INCREMENT = 10

def main
  client = SodaClient.new
  num_of_trucks = client.number_of_open_trucks
  offset = 0
  puts "\n ====== Welcome to viewing SF's open food trucks ======\n"
  client.open_trucks(offset).each do |truck|
    puts " - #{truck}"
  end

  while num_of_trucks >= offset && num_of_trucks > 0 do
    if num_of_trucks - offset < 10
      puts "\n ====== Thanks for your interest in SF Foodtrucks, these are all the currently open trucks ======\n"
      return
    else
      puts "\n ====== Hit 'enter' to view the next 10 ======\n"
    end

    user_response = gets
    if user_response == "\n"
      offset += OFFSET_INCREMENT
      client.open_trucks(offset).each do |truck|
        puts " - #{truck}"
      end
    else
      return
    end
  end
end

# calling app from main
main
