puts 'Event Manager Initialized!'

puts File.exist? "event_attendees.csv"

#this spits out everything in the csv file
"""
contents = File.read('event_attendees.csv')
puts contents
"""


#using File.readlines to save each line as a separate item in an array

"""
lines = File.readlines('event_attendees.csv')
lines.each do |line|
    puts line
end
"""

#trying to display the first names of all attendees
#using string.split to convert a string of text into an array 
#the code breaks up every line into an array separated by commas
#ex: ["1", "11/12/08 10:47", "Allison", "Nguyen", "arannon@jumpstartlab.com", 
#   "6154385000", "3155 19th St NW", "Washington", "DC", "20010\n"]
"""
lines = File.readlines('event_attendees.csv')
lines.each do |line|
    columns = line.split(',')
    p columns
end
"""

#now we can grab the first name, which would be in the array's second index column[2]

"""
lines = File.readlines('event_attendees.csv')
lines.each do |line|
    columns = line.split(',')
    name = columns[2]
    puts name
end

"""

#need to skip first row in the file as it just contains the way information
#is stored in the file 
#need to skip: [" ", "RegDate", "first_Name", "last_Name", "Email_Address",
# "HomePhone", "Street", "City", "State", "Zipcode\n"]
#can use array.each_with_index for this

lines = File.readlines("event_attendees.csv")
lines.each_with_index do |line, index|
    next if index == 0
    columns = line.split(",")
    name = columns[2]
    puts name
end
