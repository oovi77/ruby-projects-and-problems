#puts "IO test"

#$stdout.puts 'from stdout'

#io = IO.new(1)
#io.puts "from IO object"

#testing reading from a file using IO
=begin
p IO.sysopen '/home/oovi77/repos/ruby-projects-and-problems/temp_for_testing/lorem.txt'

lorem = IO.new(5)
p lorem.gets
p lorem.pos
p lorem.gets
p lorem.gets
p lorem.pos
p lorem.gets
p lorem.eof?
p lorem.rewind
p lorem.pos
p lorem.gets
=end

=begin
fd = IO.sysopen '/home/oovi77/repos/ruby-projects-and-problems/temp_for_testing/test1.txt', 'w+'
p fd
io = IO.new(fd)
p io
io.puts "hello world"
io.puts "goodbye world"
p io.gets
p io.eof?
io.rewind
p io.gets
=end

#testing YAML format

=begin
require 'yaml'
p YAML.load File.read('test.yaml')  #results in a nicely formatted hash
=end

# above looks like this:
=begin
{"name"=>"David",
 "height"=>124,
 "age"=>28,
 "children"=>{"John"=>{"age"=>1, "height"=>10},
             "Adam"=>{"age"=>2, "height"=>20},
             "Robert"=>{"age"=>3, "height"=>30}},
 "traits"=>["smart", "nice", "caring"]}
=end



#YAML format example
=begin
require 'yaml'

class Person
    attr_accessor :name, :age, :gender

    def initialize(name, age, gender)
        @name = name
        @age = age
        @gender = gender
    end

    def to_yaml
        YAML.dump ({
            :name => @name,
            :age => @age,
            :gender => @gender
        })
    end

    def self.from_yaml(string)
        data = YAML.load string
        p "outputing data... "
        p data
        self.new(data[:name], data[:age], data[:gender])
    end
end

david = Person.new("David", 28,"male")
p "david is: #{david}"
str_yaml = david.to_yaml
p "str_yaml is: #{str_yaml}"
result = Person.from_yaml(str_yaml)
p "result is: #{result}"

=end


=begin

require 'json'
temp = JSON.load File.read("testj.json")
p "temp is: "
p temp
=end


#going back to the Person class example with YAML
#and changing it to work with JSON:


=begin
require 'json'

class Person
    attr_accessor :name, :age, :gender

    def initialize(name, age, gender)
        @name = name
        @age = age
        @gender = gender
    end

    def to_json
        JSON.dump ({
            :name => @name,
            :age => @age,
            :gender =>@gender
        })
    end

    def self.from_json(string)
        data = JSON.load string
        p "outputing data... "
        p data
        self.new(data[:name], data[:age], data[:gender])
    end
end

david = Person.new("David", 28,"male")
p "david is: #{david}"
str_json = david.to_json
p "str_json is: #{str_json}"
result = Person.from_json(str_json)
p "result is: #{result}"
=end


#MessagePack format

=begin
require 'msgpack'
msg = {:height => 47, :width => 32, :depth => 16}.to_msgpack

#prints out mumbo-jumbo
p msg

obj = MessagePack.unpack(msg)
p obj
=end



#-----Using mixins, Modularizing with Mixins

=begin
require 'json'

#mixin 
module BasicSerializable

    #should point to a class; change to a different 
    #class (e.g. MessagePack, JSON, YAML) to get a different
    #serialization

    @@serializer = JSON

    def serialize
        obj = {}
        instance_variables.map do |var|
            obj[var] = instance_variable_get(var)
        end
    
    @@serializer.dump obj
    end

    def unserialize(string)
        obj = @@serializer.parse(string)
        obj.keys.each do |key|
             instance_variable_set(key, obj[key])
        end
    end

end


class Person
    include BasicSerializable

    attr_accessor :name, :age, :gender

    def initialize(name, age, gender)
        @name = name
        @age = age
        @gender = gender
    end
end

p = Person.new "David", 28, "male"
p p.serialize

p p.unserialize (p.serialize)
puts "Name #{p.name}"
puts "Age #{p.age}"
puts "Gender #{p.gender}"

=end

=begin
david = Person.new("David", 28, "male")
p "david is: #{david}"
d_serialized = david.serialize
p "d_ser is: #{d_serialized}"
p "david is: #{david}"
d_unser = david.unserialize (d_serialized)
p "d_unser is: #{d_unser}"

#puts "Name is: #{d_unser.name}"
=end

''' this is a different way to comment rather than using begin and end
puts "test"
'''

#Code examples now from the Ruby Book of Bastards input / output section

'''
fname = "sample.txt"
somefile = File.open(fname, "w")
somefile.puts "Hello file!"
somefile.close
'''


'''
file = File.open("sample.txt", "r")
contents = file.read
puts "contents is: #{contents}"

contents = file.read
puts "----"
puts contents
'''

#contents = File.open("sample.txt", 'r') {|file| file.read}
#puts contents


#using readlines
'''
File.open("sample.txt").readlines.each do |line|
    puts line
 end
'''

#using readline
'''
file = File.open("sample.txt", "r")
while !file.eof?
   line = file.readline
   puts "line is: #{line}"
end
'''


#using readlines problem description
'''
Reads hamlet.txt from the given URL
Saves it to a local file on your hard drive named "hamlet.txt"
Re-opens that local version of hamlet.txt and prints out every 42nd line to the screen
'''

=begin
require 'open-uri'
url = "http://ruby.bastardsbook.com/files/fundamentals/hamlet.txt"
file_h = URI.open(url)

file_local_hamlet = File.open("hamlet_local.txt", "w")


while !file_h.eof?
   line = file_h.readline
   file_local_hamlet.puts line
end

file_local_hamlet.close

File.open("hamlet_local.txt", "r") do |file|
    file.readlines.each_with_index do |line, idx|
        puts line if idx % 42 == 41
    end
end
=end







#URI.open(url) {|f|
#    puts f.readline
#}

'''
all_of_hamlet = URI.open(url).readlines

all_of_hamlet.each_with_index do |val, idx| 
    if idx == 0
        puts "val is: #{val}"
    end
end
'''

#puts Dir.glob('../temp_for_testing/*').length   

=begin
puts Dir.pwd
fls = Dir.entries '.'
puts fls.inspect
=end

#data = system 'ls'
#puts data















