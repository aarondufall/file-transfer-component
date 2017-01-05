require_relative '../client_test_init'

file_id = ENV['FILE_ID']
name = ENV['NAME']
uri = ENV['URI']

file_id ||= Identifier::UUID::Random.get
name ||= 'test.md'
uri ||= './fixtures/test.md'

Client::Initiate.(file_id, name, uri)

puts file_id

