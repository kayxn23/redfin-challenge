class FoodTruck

  def initialize(truck_data)
    @truck = truck_data
  end

  def to_s
    return "#{@truck.applicant} located at #{@truck.location} and is open between #{@truck.starttime} and #{@truck.endtime}"
  end

end
