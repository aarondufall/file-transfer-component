module FileTransferComponent
  module Messages
    module Events
      class FileNotFound
        include Messaging::Message

        attribute :file_id, String
        attribute :user_id, String
        attribute :team_id, String
        attribute :name, String
        attribute :uri, String
        attribute :time, String
        attribute :source, String
        attribute :processed_time, String
      end
    end
  end
end
