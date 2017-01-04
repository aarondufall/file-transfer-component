module FileTransferComponent
  class Store
    include EntityStore

    category 'file_transfer'
    entity File
    projection Projection
    reader EventSource::Postgres::Read
  end
end
