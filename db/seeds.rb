require_relative '../lib/library'
Dir[File.join('db', 'seeds', '*.rb')].sort.each do |seed|
  puts "Loading seed for | #{File.basename(seed)}"
  load seed
end
