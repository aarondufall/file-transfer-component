module FileTransferComponent
  module Controls
    module Events
      module NotFound
        def self.example
          not_found = FileTransferComponent::Messages::Events::NotFound.build

          not_found.file_id = ID.example
          not_found.name = "some_name"
          not_found.uri = "some_uri"
          not_found.time = Controls::Time::Effective.example
          not_found.processed_time = Controls::Time::Processed.example

          not_found
        end
      end
    end
  end
end
