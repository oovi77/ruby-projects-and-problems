puts "sub strings problemo"

=begin
Implement a method #substrings that takes a word as the first argument
and then an array of valid substrings (your dictionary) as the second
argument. It should return a hash listing each substring (case insensitive)
that was found in the original string and how many times it was found.

  > dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
  => ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

  > substrings("below", dictionary)
  => { "below" => 1, "low" => 1 }


  Next, make sure your method can handle multiple words:
  > substrings("Howdy partner, sit down! How's it going?", dictionary)
  => { "down" => 1, "go" => 1, "going" => 1, "how" => 2, "howdy" => 1, 
    "it" => 2, "i" => 3, "own" => 1, "part" => 1, "partner" => 1, "sit" => 1 }

=end


def substrings(sentence, dictionary)

    result = Hash.new(0)
    sentence = sentence.split
    sentence = sentence.map {|element| element.downcase}
    p sentence

    dictionary.each do |string|
        sentence.each do |word|
            if (word.include?(string))
                result[string] += 1
            end
        end
    end

    return result
end


dictionary1 = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

p substrings("BeLow", dictionary1)   #this works { "below" => 1, "low" => 1 }
p substrings("Howdy partner, sit down! How's it going?", dictionary1)


#ROUGH WORK

#"string".split 
=begin
temp = "Howdy partner, sit down! How's it going?"
p temp.split # ["Howdy", "partner,", "sit", "down!", "How's", "it", "going?"]
t1 = "howdy"
p t1.split
=end

#1. loop through each subtring in dictionary
#2. for each substring in dictionary, loop through each word in the sentance to see if it is in there
#3. update a hash each time a match occurs

#use include? to check if a match happens? look into that one hash example with votes...

#need to use map or something to make each word in sentence lowercase b/c include? is case sensitive

#s.downcase

#temp = "foo"
#p temp.include?("f")
#p temp.include?("F")

=begin
t1 = Hash.new(0)
t1["i"] += 1
p t1
=end
