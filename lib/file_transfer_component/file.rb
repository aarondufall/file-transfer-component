module FileTransferComponent
  class File
    include Schema::DataStructure

    attribute :id, String
    attribute :name, String
    attribute :key, String
    attribute :bucket, String
    attribute :region, String
    attribute :initiated_time, Time
    attribute :permanent_storage_time, Time
    attribute :not_found_time, Time

    def not_found?
      !not_found_time.nil?
    end

    def stored_permanently?
      !permanent_storage_time.nil?
    end
  end
end
