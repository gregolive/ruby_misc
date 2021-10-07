require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'time'

civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phone_number(number)
  plain_num = number.delete('^0-9')
  plain_num.slice!(0) if (plain_num.length == 11 && plain_num[0,1] == "1")
  plain_num.length == 10 ? plain_num : nil
end

def date_to_hour(date)
  Time.strptime(date, "%m/%d/%Y %k:%M").hour
end

def date_to_day(date)
  Time.strptime(date, "%m/%d/%Y %k:%M").wday
end

def add_time(hash, key)
  if hash.has_key?(key) == false
    hash[key] = 1
  else
    hash[key] += 1
  end
  hash.sort_by{ |k, v| -v }.to_h
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    legislators = civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letters(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'Event Manager Initialized!'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

sign_up_times = {}
sign_up_days = {}

contents.each do |row|
  id = row[0]
  name = row[:first_name]

  phone_number = clean_phone_number(row[:homephone])

  reg_hour = date_to_hour(row[:regdate])
  sign_up_times = add_time(sign_up_times, reg_hour)

  reg_day = date_to_day(row[:regdate])
  sign_up_days = add_time(sign_up_days, reg_day)

  zipcode = clean_zipcode(row[:zipcode])

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)
  
  save_thank_you_letters(id, form_letter)
end
