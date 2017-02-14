module FileTransferComponent
  module FileStorage
    class Remote

      configure :permanent_storage

      setting :access_key_id
      setting :secret_access_key 

      def self.build(settings: nil)
        settings ||= Settings.instance
        instance = new
        settings.set(instance)
        instance
      end

      def put(local_path, region, bucket, key)

        s3 = Aws::S3::Resource.new(region: region, credentials: credentials)
        
        bucket = s3.bucket(bucket)
        obj = bucket.object(key)
        
        begin
          obj.upload_file(local_path)
        rescue Errno::ENOENT
          raise LocalFileNotFound
        end
        
        obj
      end

      def credentials
        @credentials ||= Aws::Credentials.new(access_key_id, secret_access_key)
      end

      LocalFileNotFound = Class.new(StandardError)

      class Substitute
        def put(*args)
        end
      end
    end
  end
end
