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



'''













