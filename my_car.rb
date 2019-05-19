class Vehicle
  attr_accessor :color, :speed
  attr_reader :year, :model, :vehicle

  @@object_counter = 0

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @vehicle = case
               when self.class == MyCar   then "car"
               when self.class == MyTruck then "truck"
               else                            "vehicle"
               end
    @@object_counter += 1
  end

  def self.number_of_objects
    "I have created #{@@object_counter} vehicles."
  end
  
  def gas_mileage(miles, gallons)
    "Vehicle gas mileage: #{miles/gallons} miles/gallon of gas"
  end

  def speed_up(number)
    self.speed += number
  end

  def brake(number)
    self.speed -= number
  end

  def shut_off
    self.speed = 0
  end

  def info
    "My #{vehicle} is currently going #{self.speed} mph"
  end

  def spray_paint(color)
    self.color = color
  end

  def to_s
    "My #{vehicle} is a #{year}, #{color}, #{model}"
  end  
end

class MyCar < Vehicle
end

class MyTruck < Vehicle
end

my_car = MyCar.new("2018", "red", "Mazda")
my_truck = MyTruck.new('2010', 'white', 'Ford Tundra')

puts Vehicle.number_of_objects
puts
puts my_car
puts my_truck
puts
puts my_car.info
puts my_truck.info
