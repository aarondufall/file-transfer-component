module FileTransferComponent
  module Messages
    module Commands
      class Initiate
        include Messaging::Message

        attribute :file_id, String
        attribute :name, String
        attribute :uri, String
        attribute :time, String
      end
    end
  end
end
