puts "caesar cipher"



def caesar_cipher(string, s_factor) 

    converted_str = ""

    #-5, same as  a, b, c, d, e, f   (q r s t u v w x y z)
    # f becomes a
    # a becomes v

    if s_factor >= 26
        s_factor = s_factor % 26
    elsif s_factor <-26
        s_factor = (s_factor % 26)  
    elsif (s_factor <0 && s_factor >= -26)
        s_factor = s_factor + 26
    end

    #p "sfactor is: #{s_factor}"
          
    #redo with organizing it by c (the ascii num) instead of by result
    string.each_byte do |c|
        result = c + s_factor

        if (c >= 97 && c <= 122) #case for letters between "a" and "z"
            if result > 122
                converted_str += ((96 + (result - 122)).chr) #small letter overflow
                #for debugging, comment out to see conversion
                #p "Converting #{c.chr} to #{((96 + (result - 122)).chr)}"
            else
                converted_str += (result.chr)
                #p "Converting #{c.chr} to #{(result.chr)}"
            end
        elsif (c >= 65 && c<= 90)
            if result > 90
                converted_str += ((64 + (result - 90)).chr)
                #p "Converting #{c.chr} to #{((64 + (result - 90)).chr)}"
            else
                converted_str += (result.chr)
                #p "Converting #{c.chr} to #{(result.chr)}"
            end
        else
            converted_str += (c.chr)
            #p "Converting #{c.chr} to #{(result.chr)}"
        end
    end       

    return converted_str
end

#p caesar_cipher("a b y z", -83)
#p caesar_cipher("Zz", 83) #should be 'Ee'
#p caesar_cipher("Ee", -83) #should be 'Zz'

#p caesar_cipher("Hello, World!", 75)
# p ",".ord
# p 44 + 23
#p -83 % 26 #=21
#p 75 / 26.0
#p 2 * 26
#p 75 - 52

#TESTING

#p caesar_cipher("What a string!" , 5)
p caesar_cipher('Zz', 5) #yes -> Ee
p caesar_cipher('Ee', -5) #no, should be 'Zz'
p caesar_cipher('Zz', 83) #yes, -> Ee
p caesar_cipher('Ee', -83) #no, Zz
p caesar_cipher('What a string!', 5) #yes

#p 87 + 23
#p "W".ord
#p "H".ord
#p 72 + 23
p caesar_cipher('Hello, World!', 75) #no, should be: 'Ebiil, Tloia!'
p caesar_cipher('Hello, World!', -55) #'Ebiil, Tloia!'




=begin
p "a is:  #{"a".ord}"  #97
p "z is:  #{"z".ord}"  #122

p "A is:  #{"A".ord}"  #65
p "Z is:  #{"Z".ord}"  #90
=end

#check rspec debugging in solutions to see if my answer is correct, try to refactor maybe?


=begin
caesar_cipher("What a string!", 5)
=> "Bmfy f xywnsl!"
=end

#Rough Work

=begin
temp = "a"
t2 = "A"
p temp.ord
p t2.ord

p 65.chr
=end

#p temp.b

=begin
p "s".ord
p "t".ord
p "r".ord
p "i".ord
p "n".ord
p "g".ord
=end

=begin
"string".each_byte do |c|
    puts c
end
=end

=begin
p "a is:  #{"a".ord}"  #97
p "z is:  #{"z".ord}"  #122

p "A is:  #{"A".ord}"  #65
p "Z is:  #{"Z".ord}"  #90
=end


=begin
def caesar_cipher(string, s_factor) 

    converted_str = []
    
    string.each_byte do |c|
        result = c + s_factor
        if (result > 122)
            converted_str.push((96 + (result - 122)).chr)
        elsif (result >= 97 && result <=122)
            converted_str.push(result.chr)
        elsif (result>= 65 && result <=90)
            converted_str.push(result.chr)
        elsif (result > 90)
            converted_str.push((64 + (result - 90)).chr)
        else
            converted_str.push(c.chr)
        end
    end

    return converted_str
end
=end


=begin
p "a is:  #{"a".ord}"  #97
p "z is:  #{"z".ord}"  #122

p "A is:  #{"A".ord}"  #65
p "Z is:  #{"Z".ord}"  #90
=end

=begin
def caesar_cipher(string, s_factor) 

    converted_str = ""

    #-5, same as  a, b, c, d, e, f   (q r s t u v w x y z)
    # f becomes a
    # a becomes v
    if s_factor >= 26
        s_factor = s_factor % 26
    elsif s_factor <-26
        s_factor = (s_factor % 26)  
    elsif (s_factor <0 && s_factor >= -26)
        s_factor = s_factor + 26
    end

    p "sfactor is: #{s_factor}"
          
    #redo with organizing it by c (the ascii num) instead of by result
    string.each_byte do |c|
        result = c + s_factor
        if ( (c >= 65 && c <= 90) || (c >= 90 && c <= 122))

            if (result > 122)
                converted_str += ((96 + (result - 122)).chr) #small letter overflow
                #for debugging, comment out to see conversion
                p "Converting #{c.chr} to #{((96 + (result - 122)).chr)}"
            elsif (result >= 97 && result <=122)
                converted_str += (result.chr)
                p "Converting #{c.chr} to #{(result.chr)}"
            elsif (result>= 65 && result <=90)
                converted_str += (result.chr)
                p "Converting #{c.chr} to #{(result.chr)}"
            elsif (result > 90)
                converted_str += ((64 + (result - 90)).chr)
                p "Converting #{c.chr} to #{((64 + (result - 90)).chr)}"
            end
        else
            converted_str += (c.chr)
            p "Converting #{c.chr} to #{c.chr}"
        end
          
    end

    return converted_str
end
=end