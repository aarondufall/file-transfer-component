module FileTransferComponent
  module Controls
    module Events
      module CopiedToS3
        def self.example
          copied_to_s3 = FileTransferComponent::Messages::Events::CopiedToS3.build
          
          copied_to_s3.file_id = ID.example
          copied_to_s3.key = "path/to/some_file"
          copied_to_s3.bucket = "some bucket"
          copied_to_s3.region = "some_region"
          copied_to_s3.processed_time = Controls::Time::Processed.example

          copied_to_s3
        end
      end
    end
  end
end
