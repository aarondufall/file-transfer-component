module FileTransferComponent
  module FileStorage
    class Permanent

      def configure(receiver)
        receiver.permanent_storage = new
      end

      def save(uri, region, bucket, key)
        s3 = Aws::S3::Resource.new(region: region)
        obj = s3.bucket(bucket).object(key)
        obj.upload_file(uri)
      end

      class Substitute
        attr_writer :saved
        def save(uri, region, bucket, key)
          @saved ||= nil
        end
      end
    end
  end
end
