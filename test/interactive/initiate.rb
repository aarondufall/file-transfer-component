require_relative '../client_test_init'
require_relative '../test_init'

name = ENV['NAME']
uri = ENV['URI']

name ||= 'test.md'
uri ||= FileTransferComponent::Controls::URI.file

file_id = Client::Initiate.(name, uri)

puts file_id


