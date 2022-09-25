#puts 'Event Manager Initialized!'

#puts File.exist? "event_attendees.csv"

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

'''
lines = File.readlines("event_attendees.csv")
lines.each_with_index do |line, index|
    next if index == 0
    columns = line.split(",")
    name = columns[2]
    puts name
end
'''


#Iteration 1, Parsing with CSV, using Ruby's CSV library

'''
require "csv"

contents = CSV.open("event_attendees.csv", headers:true)
contents.each do |row|
    name = row[2]
    puts name
end
'''

#converting heads to symbols so column names are easier to use / identify

'''
require "csv"
contents = CSV.open(
    "event_attendees.csv",
    headers: true,
    header_converters: :symbol
)

contents.each do |row|
    name = row[:first_name]
    puts name
end

'''

#displaying the zipcodes is now easy with the new head config, just use :zipcode

=begin
require 'csv'

contents = CSV.open(
    'event_attendees.csv',
    headers: true,
    header_converters: :symbol
)

contents.each do |row|
    name = row[:first_name]
    zipcode = row[:zipcode]
    puts "#{name} #{zipcode}"
end

=end


#Iteration 2: Cleaning up our zip codes
'''
Pseudocode for cleaning up zip codes

if the zipcode is exactly 5 digits, assume that it is ok
if the zipcode is more than 5 digits, truncate it to the first 5 digits
if the zipcode is less than 5 digits, add zeros to the front until it
becomes five digits

'''

=begin
require "csv"

contents = CSV.open(
    'event_attendees.csv',
    headers: true,
    header_converters: :symbol
)

contents.each do |row|
    name = row[:first_name]
    zipcode = row[:zipcode]

    if zipcode.nil?
        zipcode = '00000'
    elsif zipcode.length < 5
        zipcode = zipcode.rjust(5, '0')
    elsif zipcode.length > 5
        zipcode = zipcode[0..4]
    end

    puts "#{name} #{zipcode}"
end
=end

=begin
require 'csv'

def clean_zipcode(zipcode)
  if zipcode.nil?
    '00000'
  elsif zipcode.length < 5
    zipcode.rjust(5, '0')
  elsif zipcode.length > 5
    zipcode[0..4]
  else
    zipcode
  end
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

contents.each do |row|
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])

  puts "#{name} #{zipcode}"
end
=end


#refactoring clean_zipcode even more to just one line:

=begin
require 'csv'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

contents.each do |row|
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])

  puts "#{name} #{zipcode}"
end
=end


#using the google API
=begin

-set the API key
-send the query with the given criteria
-parse the respone for the names of your legislators

=end

=begin
require 'google/apis/civicinfo_v2'
civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new

p civic_info
p "1-------"

civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

p civic_info.key
p "2-------"

response = civic_info.representative_info_by_address(address: 80202, levels: 'country', roles: ['legislatorUpperBody', 'legislatorLowerBody'])

p response
p "3-------"
=end


#getting the information needed using .officials method on response

=begin
require 'csv'
require 'google/apis/civicinfo_v2'

civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

contents.each do |row|
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])

  begin
    legislators = civic_info.representative_info_by_address(
      address: zipcode,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    )
    legislators = legislators.officials

    legislator_names = legislators.map(&:name)

    legislators_string = legislator_names.join(", ")
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end

  puts "#{name} #{zipcode} #{legislators_string}"
end

=end


#moving displaying legislators into a method

=begin

require 'csv'
require 'google/apis/civicinfo_v2'


def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    legislators = civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    )
    legislators = legislators.officials
    legislator_names = legislators.map(&:name)
    legislator_names.join(", ")
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

contents.each do |row|
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])

  legislators = legislators_by_zipcode(zipcode)

  puts "#{name} #{zipcode} #{legislators}"
end

=end



#Iteration #4 - Form Letters

#saving this to a file named form_letter.html

=begin
form_letter = %{
  <html>
  <head>
    <title>Thank You!</title>
  </head>
  <body>
    <h1>Thanks FIRST_NAME!</h1>
    <p>Thanks for coming to our conference.  We couldn't have done it without you!</p>

    <p>
      Political activism is at the heart of any democracy and your voice needs to be heard.
      Please consider reaching out to your following representatives:
    </p>

    <table>
      <tr><th>Legislators</th></tr>
      <tr><td>LEGISLATORS</td></tr>
    </table>
  </body>
  </html>
}
=end

#taking the form and using gsub and gsub! to replace the FIRST_NAME in the form
#and LEGISLATORS with their respective values


=begin
require 'csv'
require 'google/apis/civicinfo_v2'


def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    legislators = civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    )
    legislators = legislators.officials
    legislator_names = legislators.map(&:name)
    legislator_names.join(", ")
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.html')

contents.each do |row|
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])

  legislators = legislators_by_zipcode(zipcode)
  personal_letter = template_letter.gsub('FIRST_NAME', name)
  personal_letter.gsub!('LEGISLATORS', legislators)
  puts personal_letter
end

=end


'''
Using Rubys ERB template language
'''

=begin

require 'erb'
meaning_of_life = 42

question = "Everything is <%= meaning_of_life %>"
template = ERB.new question

results = template.result(binding)
puts results

=end


'''
Using ERB templates in the main problem:
'''


=begin
require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

contents.each do |row|
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)
  puts form_letter
end

=end

=begin
'''
Final event manager example, creating a separate folder with the letters generated as
individual files
'''

require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id,form_letter)
end

=end




#Assignment Clean Phone Numbers
'''
Similar to the zip codes, the phone numbers suffer from multiple formats and inconsistencies. 
If we wanted to allow individuals to sign up for mobile alerts with the phone numbers, 
we would need to make sure all of the numbers are valid and well-formed.


If the phone number is less than 10 digits, assume that it is a bad number
If the phone number is 10 digits, assume that it is good
If the phone number is 11 digits and the first number is 1, trim the 1 and
use the remaining 10 digits

If the phone number is 11 digits and the first number is not 1, then it is a bad number
If the phone number is more than 11 digits, assume that it is a bad number


'''

=begin
require 'csv'

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

#need to clean-up / format these various types of phone numbers
'''
6154385000
414-520-5000
(941)979-2000
613 565-4000
(202) 328 1000
858 405 3000
(603) 305-3000
9.82E+00
14018685000
'''

contents.each do |row|
  original_num = row[:homephone]
  phone_num = row[:homephone]
  num_split = phone_num.split(//)   
  
  phone_num = ""
 
  num_split.each do |num|
    if num == "0" 
      phone_num += num
    elsif num.to_i != 0
      phone_num += num
    end
  end

  if phone_num.length < 10
    phone_num = "0000000000"
  elsif phone_num[0] == "1" && phone_num.length == 11
    phone_num = phone_num[1..phone_num.length]
  elsif phone_num.length >= 11
    phone_num = "0000000000"
  end
  
  puts "#{original_num}  converted to: #{phone_num}"
end

=end


=begin
#puts "#{phone_num.split(//)}"
#example, gets this: ["6", "1", "5", "4", "3", "8", "5", "0", "0", "0"]
t1 = "temp"
t2 = t1.split(//)
puts "t1 is: #{t1}   t2 is: #{t2}"
=end



##################################################################

#Time-Targeting Assignment
#find out peak registration hours

=begin

require 'csv'



# ,RegDate,first_Name,last_Name,Email_Address,HomePhone,Street,City,State,Zipcode


contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

#example of what is in regdate
#"11/12/08 16:05" , mm/dd/yy  time (time in 24h format)

#date.strptime, parses the given representation of data and time and creates a date object
"""
temp = Date.strptime('2001-02-03', '%Y-%m-%d')
p temp
puts temp
puts '-------'
"""

"""
d = Date.parse('3rd Feb 2001')
                             #=> #<Date: 2001-02-03 ...>
p d.year                       #=> 2001
p d.mon                        #=> 2
p d.mday                       #=> 3
p d.wday                       #=> 6
p d += 1                       #=> #<Date: 2001-02-04 ...>
p d.strftime('%a %d %b %Y')    #=> 'Sun 04 Feb 2001'

"""

count_hours = Hash.new(0)

contents.each do |row|
  date_time = row[:regdate]
  time = date_time.split(" ")[1]
  hour = time.split(":")[0]
  #p hour
  # have the hour, probably want to use a hash to keep track of it
  count_hours[hour] += 1
end

p count_hours

max_hour = 0
peak_hour = ""

count_hours.each do |key, value|
  if value >= max_hour
    max_hour = value
    peak_hour = key
  end
end

puts "peak hour is: #{peak_hour}"

=end

#*************!!!!!!!!!!***********


##################################################################

#Day of the week targeting Assignment
#find out what days of the week did most people register

require 'csv'
require 'date'


# ,RegDate,first_Name,last_Name,Email_Address,HomePhone,Street,City,State,Zipcode


contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

#example of what is in regdate
#"11/12/08 16:05" , mm/dd/yy  time (time in 24h format)

#date.strptime, parses the given representation of data and time and creates a date object
"""
temp = Date.strptime('2001-02-03', '%Y-%m-%d')
p temp
puts temp
puts '-------'
"""


"""
d = Date.parse('3rd Feb 2001')
                             #=> #<Date: 2001-02-03 ...>
p d.year                       #=> 2001
p d.mon                        #=> 2
p d.mday                       #=> 3
p d.wday                       #=> 6
p d += 1                       #=> #<Date: 2001-02-04 ...>
p d.strftime('%a %d %b %Y')    #=> 'Sun 04 Feb 2001'

"""

count_weeks = Hash.new(0)

contents.each do |row|

  date = Date.strptime(row[:regdate].split[0], '%m/%d/%y')
  #p date
  week = date.wday
  count_weeks[week] += 1

  #date = row[:regdate].split[0]
  #p date

  #time = date_time.split(" ")[1]
  #hour = time.split(":")[0]
  #p hour
  # have the hour, probably want to use a hash to keep track of it
  
  #count_hours[hour] += 1
end

p count_weeks

max_week = 0
count = 0
count_weeks.each do |key, value|
  if value >= count
    count = value
    max_week = key
  end
end

p "Peak day of week is: #{Date::ABBR_DAYNAMES[max_week]}"


#temp = Date.strptime('2001-02-03', '%Y-%m-%d')
#temp = Date.strptime('08/11/23', '%y/%m/%d')
#temp1 = Date.strptime('08/11/20', '%y/%m/%d')

=begin
temp = Date.strptime('11/20/08', '%m/%d/%y')
temp1 = Date.strptime('11/23/08', '%m/%d/%y')
p temp.wday #0
p temp1.wday #4
puts '-------'
=end

=begin
p count_hours

max_hour = 0
peak_hour = ""

count_hours.each do |key, value|
  if value >= max_hour
    max_hour = value
    peak_hour = key
  end
end

#puts "peak hour is: #{peak_hour}"
=end






