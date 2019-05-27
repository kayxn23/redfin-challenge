require 'soda/client'
require_relative 'current_time'
require_relative 'food_truck'

class SodaClient

  def initialize
    @client = SODA::Client.new({:domain => BASE_URL , :app_token => APP_TOKEN})
    @current_pacific_time = CurrentTime.pacific
  end

  BASE_URL = "data.sfgov.org"
  APP_TOKEN = ENV["soda_token"]
  LIMIT_TRUCKS_PER_PAGE = 10
  SF_MOBILE_FOOD_SCHEDULE_DATASET_ID = "jjew-r69b"

  def open_trucks(offset_num = 0)
    trucks_open_now = []
    get_open_trucks(offset_num).each do |truck|
      trucks_open_now << FoodTruck.new(truck)
    end
    return trucks_open_now
  end

  def number_of_open_trucks
    response = @client.get(SF_MOBILE_FOOD_SCHEDULE_DATASET_ID,
              {"$select" => "distinct applicant , location, starttime, endtime, start24, end24",
                "$order" => 'applicant',
                "$where" => "start24 <= '#{@current_pacific_time}' AND end24 >= '#{@current_pacific_time}'"
              })
    return response.body.length
  end

  private

  def get_open_trucks(off_set_num)
    response = @client.get(SF_MOBILE_FOOD_SCHEDULE_DATASET_ID,
              {"$select" => "distinct applicant , location, starttime, endtime, start24, end24",
                "$order" => 'applicant',
                "$where" => "start24 <= '#{@current_pacific_time}' AND end24 >= '#{@current_pacific_time}'",
                "$limit" => LIMIT_TRUCKS_PER_PAGE,
                "$offset" => off_set_num })
    return response.body
  end

end
