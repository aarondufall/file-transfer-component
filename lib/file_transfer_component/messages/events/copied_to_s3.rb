module FileTransferComponent
  module Messages
    module Events
      class CopiedToS3
        include Messaging::Message

        attribute :file_id, String
        attribute :key, String
        attribute :bucket, String
        attribute :region, String
        attribute :processed_time, String

      end
    end
  end
end
