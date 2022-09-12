=begin

class MyCar

  attr_accessor :color
  attr_reader :year
  
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
  end

  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph."
  end

  def brake(number)
    @current_speed -= number
    puts "You push the brake and decelerate #{number} mph."
  end

  def current_speed
    puts "You are now going #{@current_speed} mph."
  end

  def shut_down
    @current_speed = 0
    puts "Let's park this bad boy!"
  end

  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks great!"
  end
    
end
=end

=begin

lumina = MyCar.new(1997, 'white','chevy lumina')

lumina.speed_up(20)
lumina.current_speed
lumina.brake(5)
lumina.current_speed
lumina.shut_down
lumina.current_speed

puts lumina.year
puts lumina.color
lumina.color = "red"
puts lumina.color
lumina.spray_paint("blue")
puts lumina.color

=end

=begin

class GoodDog

  attr_accessor :name, :height, :weight
  #this one line of code gives use 6 getter/setter instance methods"
  #name, name=, height, height=, weight, weight=
  #it also gives us three instance variables, @name, @height, and @weight
  
  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

   def speak
    "#{name} says arf!"    #by removing the @ symbol, we are now calling the instance method
                           #rather than the instance variable
  end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
    puts "test"
    puts info
  end

  def info
     "#{name} weighs #{weight} and is #{height} tall."
  end

  def self.what_am_i
    puts "I'm a GoodDog class!"
  end
  
 
  
end

sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
#puts sparky.info

sparky.change_info('Spartacus', '24 inches', '45 lbs')
#puts sparky.info
GoodDog.what_am_i

=end


=begin
sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.name            # => "Sparky"
sparky.name = "Spartacus"
puts sparky.name            # => "Spartacus"
=end

=begin
class GoodDog
  @@number_of_dogs = 0

  def initialize
    @@number_of_dogs += 1
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end
end

puts GoodDog.total_number_of_dogs   # => 0

dog1 = GoodDog.new
dog2 = GoodDog.new

puts GoodDog.total_number_of_dogs   # => 2
=end

=begin
class GoodDog
  DOG_YEARS = 7

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age = a * DOG_YEARS
  end
end


sparky = GoodDog.new("Sparky", 4)
puts sparky.age             # => 28
puts sparky
p sparky
=end

=begin
class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end

  def what_is_self
    self
  end

  puts "yo"
  puts self
  
end

sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
p sparky.what_is_self
# => #<GoodDog:0x007f83ac062b38 @name="Sparky", @height="12 inches", @weight="10 lbs">
=end

## Exercises Classes and objects part 2
# Add a class method to your MyCar class that calculates the gas mileage of any car.

=begin
class MyCar

  attr_accessor :color
  attr_reader :year
  attr_reader :model
  
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
  end

  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph."
  end

  def brake(number)
    @current_speed -= number
    puts "You push the brake and decelerate #{number} mph."
  end

  def current_speed
    puts "You are now going #{@current_speed} mph."
  end

  def shut_down
    @current_speed = 0
    puts "Let's park this bad boy!"
  end

  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks great!"
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def to_s
    puts "My car is a #{year} #{color} #{model}."
  end
  
  
    
end

=end

=begin
lumina = MyCar.new(1997, 'white','chevy lumina')
puts lumina.year
MyCar.gas_mileage(13, 351)
puts lumina



lumina.speed_up(20)
lumina.current_speed
lumina.brake(5)
lumina.current_speed
lumina.shut_down
lumina.current_speed

puts lumina.year
puts lumina.color
lumina.color = "red"
puts lumina.color
lumina.spray_paint("blue")
puts lumina.color

=end

=begin
class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"
puts bob.name
=end

=begin
class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
end

class Cat < Animal
end

sparky = GoodDog.new
paws = Cat.new
puts sparky.speak           # => Hello!
puts paws.speak             # => Hello!
=end

=begin
class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
    puts "in Animal initialize"
  end
end

class GoodDog < Animal
  def initialize(color)
    super
    @color = color
  end
end

class BadDog < Animal
  def initialize(age, name)
    super(name)
    @age = age
  end
end

class Bear < Animal
  def initialize(color)
    super
    @color = color
  end

end

  

#bruno = GoodDog.new("brown")
bear = Bear.new("black")
p bear
=end


=begin
module Walkable
  def walk
    "I'm walking."
  end
end

module Swimmable
  def swim
    "I'm swimming."
  end
end

module Climbable
  def climb
    "I'm climbing."
  end
end

class Animal
  include Walkable

  def speak
    "I'm an animal, and I speak!"
  end
end


puts "---Animal method lookup---"
puts Animal.ancestors
=end

=begin
class Person
  def initialize(age)
    @age = age
  end

  def older?(other_person)
    age > other_person.age
  end

  protected

  attr_reader :age
end

malory = Person.new(64)
sterling = Person.new(42)

puts malory.older?(sterling)  # => true
puts sterling.older?(malory)  # => false

#malory.age
=end

=begin
class Parent
  def say_hi
    p "Hi from Parent."
  end
end

puts Parent.superclass       # => Object
=end

#!!!----- Inheritance exercises launchschool -----------

=begin
class Vehicle

end


class MyCar

  attr_accessor :color
  attr_reader :year
  attr_reader :model
  
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
  end

  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph."
  end

  def brake(number)
    @current_speed -= number
    puts "You push the brake and decelerate #{number} mph."
  end

  def current_speed
    puts "You are now going #{@current_speed} mph."
  end

  def shut_down
    @current_speed = 0
    puts "Let's park this bad boy!"
  end

  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks great!"
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def to_s
    puts "My car is a #{year} #{color} #{model}."
  end
  
  
    
end

=end


#lumina = MyCar.new(1997, 'white','chevy lumina')


#puts lumina.year
#MyCar.gas_mileage(13, 351)
#puts lumina

=begin
lumina.speed_up(20)
lumina.current_speed
lumina.brake(5)
lumina.current_speed
lumina.shut_down
lumina.current_speed

puts lumina.year
puts lumina.color
lumina.color = "red"
puts lumina.color
lumina.spray_paint("blue")
puts lumina.color
=end

=begin
class Vehicle
  @@number_of_vehicles = 0
  
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def self.num_vehicles
    puts "Number of vehicles made: #{@@number_of_vehicles}"
  end

  def initialize
    @@number_of_vehicles += 1
  end
  
end
=end

=begin
module Truckable
  def unload_truck
    puts "truck unloaded"
  end
end
=end

=begin
module Towable
  def can_tow?(pounds)
    pounds < 2000
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
end

class MyTruck < Vehicle
  #include Truckable
  include Towable
  NUMBER_OF_DOORS = 2
end



t1 = MyCar.new
t2 = Vehicle.new
t3 = MyCar.new
t4 = MyTruck.new
Vehicle.num_vehicles
t4.can_tow?(200)

p MyCar.ancestors
p MyTruck.ancestors
p Vehicle.ancestors
p Towable.ancestors


#p Towable.can_tow?(20)
#Truckable.unload_truck
=end

=begin
class Student
  attr_accessor :name

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(person)
    if (grade > person.grade)
      puts "Well done!"
    else
      puts "That's no problem"
    end
  end
  
  protected
  attr_reader :grade

end

joe = Student.new("Joe", 90)
bob = Student.new("Bob", 85)
#p joe.grade 
joe.better_grade_than?(bob)
bob.better_grade_than?(joe)

=end

# https://medium.com/@marcellamaki/object-relationships-in-basic-ruby-1af5773fff48
# examples from the above article...

=begin
class Cinema
  attr_accessor :name, :location

  def initialize(name, location)
    @name = name
    @location = location
    @movies = []
  end

  def add_movie(movie)
    @movies << movie #adds a newly created movie object to the @movies array
    movie.cinema = self
  end
  

end

class Movie
  
  attr_accessor :title, :showtime, :cinema

  @@all = []

  def initialize(title, showtime)
    @title = title
    @showtime = showtime
    @@all << self
  end

  def mov_list
    @@all 
  end
  

end

cobble_hill = Cinema.new("Cobble Hill Cinema", "Court St, Brooklyn")
#p cobble_hill
spider_man = Movie.new("Spider-Man", "9:00")
#p spider_man
cobble_hill.add_movie(spider_man)
p cobble_hill
p spider_man.mov_list
=end


###########-----       Exception Handling              --------###############

=begin
a = 10
b = "42"

begin
  a + b 
rescue
  puts "Could not add variables a (#{a.class}) and b (#{b.class})"
else
  puts "a + b is #{a + b}"
end

=end

=begin
values = [42, 'a', 'r', 9, 5, 10022, 8.7, "sharon", "Libya", "Mars", "12", 98, rand + rand, {:dog=>'cat'}, 100, nil, 200.0000, Object, 680, 3.14, "Steve", 78, "Argo"].shuffle

while values.length > 0
  a = values.pop
  b = values.pop
  

  begin
     a + b
  rescue
     puts "Could not add variables a (#{a.class}) and b (#{b.class})"
  else
     puts "a + b is #{a + b}"
  end
  
end  
=end

=begin
for i in 'A'..'C'
  retries = 2
  begin
    puts "Executing command #{i}"
    raise "Exception: #{i}"
  rescue Exception=>e
    puts "\tCaught: #{e}"
    if retries > 0
      puts "\tTrying #{retries} more times\n"
      retries -= 1
      sleep 2
      retry
    end  
  end
end
=end

=begin
require 'open-uri'
remote_base_url = "http://en.wikipedia.org/wiki"

[1900, 1910, 'xj3490', 2000].each do |yr|
 
 retries = 3
 
 begin
   url = "#{remote_base_url}/#{yr}"
   puts "Getting page #{url}"
   rpage = open(url)
 rescue StandardError=>e
   puts "\tError: #{e}"
   if retries > 0
       puts "\tTrying #{retries} more times"
       retries -= 1
       sleep 1
       retry
   else
       puts "\t\tCan't get #{yr}, so moving on"
   end    
 else
   puts "\tGot page for #{yr}"
 ensure   
   puts "Ensure branch; sleeping"
   sleep 1

 end
end
=end

##Ruby code quizzess

#p "hi".methods
#p "This is a sentence, kinda".split()
#p Array.new

=begin
my_array = Array.new()
#p my_array
my_array.push("nice")
my_array.push("hair")
puts my_array.inspect
p my_array
=end

#t1 = Array.new
#t1.push("fun")
#t1.push(String.new("games"))
#p t1

#my = String.new("special")
#my.push("cool")

=begin
class Dog
  def speak()
    return ("ruff ruff")
  end
end

spot = Dog.new
p spot.speak
=end

=begin
class Penguin
  def looks()
    return "We are cute!"
  end
end
=end

=begin
class Fish
  def self.general_overview()
    return "Fish are animals that live in the sea"
  end
end

p Fish.general_overview
=end

=begin
class Calculator
  def self.add(n1, n2)
    return n1 + n2
  end

end

p Calculator.add(3, 4)
=end

=begin
class Celsius 
  def initialize(temperature)
    @temperature = temperature
  end

  def to_fahrenheit
    return (@temperature * 1.8) + 32
  end
  
end

celsius = Celsius.new(10)
puts celsius.to_fahrenheit()
=end

=begin
class Dog
  def initialize(name)
    @name = name
  end

  def bark
    return "Ruff ruff"
  end
end

jimbo = Dog.new("Jimbo")
p jimbo.bark
=end

=begin
class Insect
  def initialize(age_in_days)
    @age_in_days = age_in_days
  end

  def calc_age_years
    return @age_in_days.to_f / 365
  end
  
end
=end

=begin
class Lamp
  def self.about_me
    "we brighten up people's lives"
  end
end

#p Lamp.about_me

class WaterBottle
  def initialize(size)
    @size = size
  end

  def size
    return @size
  end
end

b1 = WaterBottle.new(25)
p b1.size
=end

=begin
class Person
  def initialize(age)
    @age = age
  end

  def age=(age)
    @age = age
  end

  def age
    @age
  end
end
=end

#jim = Person.new(25)
#p jim.age
#jim.age = 28
#p jim.age

=begin
module Clueless
  def funny()
    return "as if!?"
  end
end

class Actress
  include Clueless
end

#alicia = Actress.new
#p alicia.funny

=end

=begin
module HappyHappy
  def say_something()
    return("Happy happy, joy joy")
  end
end

class Person
  include HappyHappy
end

class Alien
  include HappyHappy
end

t1 = Person.new
p t1.say_something
t2 = Alien.new
p t2.say_something
=end


=begin
module MathHelper
  def multiply_by_two(num)
    return num * 2
  end
end

class Homework
  include MathHelper
end

t1 = Homework.new
p t1.multiply_by_two(4)
=end

=begin
class Mammal
  def heartbeat?
    true
  end
end

class Dog < Mammal
end

fido = Dog.new
p fido.heartbeat?
=end


#p Array.ancestors

=begin
class BaseBallPlayer
  def initialize(hits, walks, at_bats)
    @hits = hits
    @walks = walks
    @at_bats = at_bats
  end

  def batting_average
    return @hits.to_f / @at_bats.to_f
  end

  def on_base_percentage
    return (@hits + @walks).to_f / @at_bats.to_f
  end

end

t1 = BaseBallPlayer.new(1.2, 3.2, 2)
p t1.batting_average
p t1.on_base_percentage
=end

=begin
class Person
  def initialize(first_name, last_name)
    @first_name = first_name
    @last_name = last_name
  end

  def first_name
    @first_name
  end

  def last_name
    @last_name
  end

  def full_name
    first_name + " " + last_name
  end

end

t1 = Person.new("James", "Bond")
p t1.full_name

=end


module MathHelpers
  def exponent(n1, n2)
    n1 ** n2
  end
end

class Calculator
  include MathHelpers
  def square_root(num)
    exponent(num, 0.5)
  end
end

t1 = Calculator.new
p t1.square_root(25)
p t1.square_root(81)



