# ENV['LOG_TAGS'] ||= 'event_source_postgres,event_source'
ENV['LOG_LEVEL'] ||= 'trace'

require_relative '../init'
# consumer = FileTransferComponent::Consumers::Command.build "fileTransfer:command-d8d38555-0762-4ab3-ab8a-32959af7efc0"
# p consumer.subscription.get
FileTransferComponent::Start.()

# consumer.start
# sleep
