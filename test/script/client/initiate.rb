require_relative '../../client_test_init'

puts "hello"
data = Client::Controls::Commands::Initiate.data

puts "First Command"
errors = []
Client::Initiate.(errors, data)
puts errors

puts "Second Command"
errors = []
Client::Initiate.(errors, data)
puts errors
