module FileTransferComponent
  module Start
    def self.call
      Consumers::Command.start "fileTransfer:command"
      Consumers::Event.start "fileTransfer"
    end
  end
end
