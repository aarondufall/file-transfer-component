require_relative '../../automated_init'

context "Handle Events" do
  context "File Not Found" do
    fixture = Fixtures::Handler.build(
      handler: Handlers::Events::Initiated.new,
      input_message: Controls::Events::Initiated.example,
      entity: Controls::File::Initiated.example
    )

    temporary_storage = FileTransferComponent::FileStorage::Temporary::Substitute.new
    temporary_storage.exists = false
    fixture.handler.temporary_storage = temporary_storage

    permanent_storage = FileTransferComponent::FileStorage::Permanent::Substitute.new
    permanent_storage.saved = true
    fixture.handler.permanent_storage = permanent_storage

    fixture.(output: "NotFound") do |test|

      test.assert_accepted

      test.assert_attributes_assigned([
        :file_id,
        :name,
        :uri,
        :time,
        :processed_time
      ])
    end
  end
end
