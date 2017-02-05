module FileTransferComponent
  class Projection
    include EntityProjection
    include Messages::Events

    entity_name :file

    apply Initiated do |initiated|
        SetAttributes.(file, initiated, copy: [
            {file_id: :id},
            :name,
        ])

        file.initiated_time = Time.parse(initiated.processed_time)
    end

    apply CopiedToS3 do |initiated|
        SetAttributes.(file, initiated, copy: [
            :key,
            :bucket,
            :region
        ])

        file.permanent_storage_time = Time.parse(initiated.processed_time)
    end

    apply NotFound do |not_found|
        file.not_found_time = Time.parse(not_found.processed_time)
    end
  end
end
