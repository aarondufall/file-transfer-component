module FileTransferComponent
  module FileStorage
    class Permanent

      configure :permanent_storage

      setting :access_key_id
      setting :secret_access_key 

      def self.build(settings: nil)
        settings ||= Settings.instance
        instance = new
        settings.set(instance)
        instance
      end


      def save(uri, region, bucket, key)
        s3 = Aws::S3::Resource.new(region: region, credentials: credentials)
        
        bucket = s3.bucket(bucket)
        obj = bucket.object(key)

        obj.upload_file(uri)
      end

      def credentials
        @credentials ||= Aws::Credentials.new(access_key_id, secret_access_key)
      end
    end
  end
end
