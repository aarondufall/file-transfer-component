module FileTransferComponent
  module Handlers
    class Events
      class Initiated
        include Messaging::Handle
        include Messaging::StreamName
        include FileTransferComponent::Messages::Commands
        include FileTransferComponent::Messages::Events
        include Log::Dependency

        dependency :write, Messaging::Postgres::Write
        dependency :store, FileTransferComponent::Store
        dependency :clock, Clock::UTC
        dependency :permanent_storage, FileTransferComponent::FileStorage::Permanent # ::S3
        dependency :temporary_storage, FileTransferComponent::FileStorage::Temporary

        def configure
          Messaging::Postgres::Write.configure self
          FileTransferComponent::Store.configure self
          FileTransferComponent::FileStorage::Permanent.configure self
          FileTransferComponent::FileStorage::Temporary.configure self
          Clock::UTC.configure self
        end

        category :file_transfer


        handle Messages::Events::Initiated do |initiated|
          logger.trace { "Copying file" }
          logger.trace(tag: :verbose) { initiated.pretty_inspect }

          file_id = initiated.file_id

          file, stream_version = store.get(file_id, include: :version)

          unless temporary_storage.exist?(initiated.uri)
            time = clock.iso8601
            file_missing = FileNotFound.follow(initiated)
            file_missing.processed_time = time

            stream_name = stream_name(file_id)
            write.(file_missing, stream_name, expected_version: stream_version)
            return
          end

          # Fetch setting entity
          # Check storage location

          # TODO derive from setting default to AWS montreal
          region = 'us-east'

          # TODO derive from setting or use defualt E.G. tenant name
          bucket = 'some bucket'

          # TODO system for organizing file keys
          # E.G /team_id/source/file_uuid
          key = '/hello/file'

          # Copy file to s3
          unless permanent_storage.save(initiated.uri, region, bucket, key)
            # investigate retry lib or write your own HA!
            # https://github.com/ooyala/retries
            # could be placed in permant storage class
            # or use error telemetry
            # write CopyToS3Failed
            return
          end

          time = clock.iso8601

          copied = CopiedToS3.follow(initiated, include: [:file_id])
          copied.processed_time = time

          copied.key = key
          copied.bucket = bucket
          copied.region = region

          stream_name = stream_name(file_id)
          write.(copied, stream_name, expected_version: stream_version)

          logger.info { "File copied" }
          logger.info(tag: :verbose) { copied.pretty_inspect }
        end
      end
    end
  end
end
