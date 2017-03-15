require_relative '../init'

ComponentHost.start 'file-transfer' do |host|
  host.register FileTransferComponent::Start
end
