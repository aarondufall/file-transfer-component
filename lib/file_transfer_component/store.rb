module FileTransferComponent
  class Store
    include EntityStore

    category 'file_transfer'
    entity File
    projection Projection
    reader MessageStore::Postgres::Read
  end
end
