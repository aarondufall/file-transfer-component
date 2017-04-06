require_relative '../client_test_init'
require_relative '../test_init'

name = ENV['NAME']
uri = ENV['URI']

name ||= 'some_file_name'
uri ||= File.join(Dir.pwd,'/tmp/some_file')

puts uri

unless File.exist?(uri)
  File.open(uri, 'w') { |file| file.write("some file contents") }
end

file_id = Client::Initiate.(name, uri)

command_handler = FileTransferComponent::Handlers::Commands.build
event_handler = FileTransferComponent::Handlers::Events::Initiated.build

puts "reading command"
EventSource::Postgres::Read.("fileTransfer:command") do |event_data|
  command_handler.(event_data)
end

puts "reading events"
EventSource::Postgres::Read.("fileTransfer") do |event_data|
  event_handler.(event_data)
end

store = FileTransferComponent::Store.build

file = store.get(file_id)

pp file

