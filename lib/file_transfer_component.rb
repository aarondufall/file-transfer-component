#TODO rename to FileTransferComponent
require 'pp'

require 'eventide/postgres'
require 'consumer/postgres'
require 'component_host'
require 'aws-sdk'

require 'file_transfer_component/messages/commands/initiate'

require 'file_transfer_component/messages/events/initiated'
require 'file_transfer_component/messages/events/copied_to_s3'
require 'file_transfer_component/messages/events/not_found'

require 'file_transfer_component/file'
require 'file_transfer_component/settings'

require 'file_transfer_component/file_storage/remote'

require 'file_transfer_component/projection'
require 'file_transfer_component/store'
require 'file_transfer_component/stream_names'
require 'file_transfer_component/handlers/commands'
require 'file_transfer_component/handlers/initiated'


require 'file_transfer_component/commands/command'
require 'file_transfer_component/commands/initiate'

require 'file_transfer_component/consumers/command'
require 'file_transfer_component/consumers/event'
require 'file_transfer_component/start'
