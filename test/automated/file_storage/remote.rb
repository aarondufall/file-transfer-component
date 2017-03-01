require_relative '../automated_init'

context 'File Storage' do
  context 'Remote' do
    # local_path = Controls::FileStorage::Local::Path.not_found

    context 'Put to S3' do
      local_file = Controls::FileStorage::Local.example

      file_storage = FileStorage::Remote.build
      key = Controls::FileStorage::Remote::Key.example

      region = Controls::S3::Region.example
      bucket = Controls::S3::Bucket.get

      s3_obj = file_storage.put(local_file.path, region, bucket, key)
      signed_public_url = s3_obj.presigned_url(:get, expires_in: 120)

      uploaded_file = open(signed_public_url)
      
      test 'Has Been Stored' do
        assert(uploaded_file.read == "some file contents")
      end
    end

    context 'Local Not Found' do
      test 'Raises LocalFileNotFound' do
        local_file_path = Controls::FileStorage::Local::Path.not_found

        file_storage = FileStorage::Remote.build
        key = Controls::FileStorage::Remote::Key.example

        region = Controls::S3::Region.example
        bucket = Controls::S3::Bucket.get

        assert proc { file_storage.put(local_file_path, region, bucket, key) } do 
          raises_error?(FileStorage::Remote::LocalFileNotFound)
        end
      end
    end
    
    # TODO
    # region 
    # bucket
  end
end
