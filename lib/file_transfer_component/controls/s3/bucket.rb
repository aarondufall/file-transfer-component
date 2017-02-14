module FileTransferComponent
  module Controls
    module S3
      module Bucket
        def self.example(random: nil)
          random = SecureRandom.hex(7) if random == true
          "file-transfer-component.test-bucket#{random}"
        end

        def self.get
          s3 = Aws::S3::Client.new(region: Region.example)

          bucket = self.example(random: true)

          s3.create_bucket(bucket: bucket)
          bucket
        end


      end
    end
  end
end
