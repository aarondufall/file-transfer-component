require_relative '../client_test_init'
# require_relative 'interactive_init'
# require_relative 'controls'

name = ENV['NAME']
uri = ENV['URI']

name ||= 'some_file_name'
uri ||= './tmp/some_file'

unless File.exist?
  File.open(uri, 'w') { |file| file.write("some file contents") }
end

file_id = Client::Initiate.(name, uri)

stream_name = FileTransferComponent::StreamName.command

command_handler = Handlers::Commands.build

EventSource::Postgres::Read.("fileTransferComponent:command") do |event_data|
  handler.(event_data)
end

EventSource::Postgres::Read.("fileTransferComponent") do |event_data|
  event_handler = Handlers::Events::Initiated.build
end

