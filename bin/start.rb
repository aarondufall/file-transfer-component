require_relative '../init'
fork do
  command_handler = FileTransferComponent::Handlers::Commands.build
  loop do
    EventSource::Postgres::Read.("fileTransfer:command") do |event_data|
      command_handler.(event_data)
    end  
  end
end


fork do
  event_handler = FileTransferComponent::Handlers::Events::Initiated.build
  loop do
    EventSource::Postgres::Read.("fileTransfer") do |event_data|
      event_handler.(event_data)
    end
  end
end
