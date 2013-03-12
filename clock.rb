require 'clockwork'
include Clockwork

handler do |job|
  puts "Running #{job}"
end
