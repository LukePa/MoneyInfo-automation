
require_relative "./modules/variables.rb"
require_relative "./modules/jira.rb"


input_array = ARGV

puts input_array.to_s


Jira.get_brand_data("MON-10408")