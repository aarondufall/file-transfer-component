module FileTransferComponent
  module Controls
    module Commands
      module Initiate
        def self.example

          initiate = FileTransferComponent::Messages::Commands::Initiate.build

          initiate.file_id = ID.example
          initiate.name = name
          initiate.uri = uri
          initiate.time = Controls::Time.example

          initiate
        end

        def self.data
          data = example.attributes
          data.delete(:time)
          data
        end

        def self.uri
          "some_uri"
        end

        def self.name
          "some_name"
        end
      end
    end
  end
end
