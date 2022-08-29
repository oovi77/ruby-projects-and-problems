puts "hello testing 123"

=begin
class Language
    def initialize(name, creator)
      @name = name
      @creator = creator
    end
      
    def description
      puts "I'm #{@name} and I was created by #{@creator}!"
    end
end
  
  ruby = Language.new("Ruby", "Yukihiro Matsumoto")
  python = Language.new("Python", "Guido van Rossum")
  javascript = Language.new("JavaScript", "Brendan Eich")
  
  ruby.description
  python.description
  javascript.description
  
  #p ruby

  class MyClass
    $my_variable = "Hello!"
  end
  
  puts $my_variable

=end

class Computer
    @@users = {}
    def initialize(username, password)
      @username = username
      @password = password
      @files = {}
      @@users[username] = password
    end
  
    def create(filename)
      time = Time.now
      @files[filename] = time
      puts "New file named #{filename} created by: #{@username} at #{time}"
    end
  
    def Computer.get_users
      puts "in get_users"
      return @@users
    end

end
  
  t1 = Computer.new("oovi77", "password1")
  t1.create("f_name1")
  #t1.get_users, Ruby class method, doesn't work
  #p t1.get_users