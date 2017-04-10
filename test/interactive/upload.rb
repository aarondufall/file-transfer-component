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


