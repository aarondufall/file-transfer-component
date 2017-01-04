require_relative '../../automated_init'

context "Handle Events" do
  context "Accept event" do
    fixture = Fixtures::Handler.build(
      handler: Handlers::Events::Initiated.new,
      input_message: Controls::Events::Initiated.example,
      record_new_entity: false
    )

    temporary_storage = FileTransferComponent::FileStorage::Temporary::Substitute.new
    temporary_storage.exists = true
    fixture.handler.temporary_storage = temporary_storage

    permanent_storage = FileTransferComponent::FileStorage::Permanent::Substitute.new
    permanent_storage.saved = true
    fixture.handler.permanent_storage = permanent_storage

    fixture.(output: "CopiedToS3") do |test|

      test.assert_accepted

      test.assert_attributes_assigned([
        :file_id,
        :key,
        :bucket,
        :region,
        :processed_time
      ])
    end
  end

  context "File Not Found" do
    fixture = Fixtures::Handler.build(
      handler: Handlers::Events::Initiated.new,
      input_message: Controls::Events::Initiated.example,
      record_new_entity: false
    )

    temporary_storage = FileTransferComponent::FileStorage::Temporary::Substitute.new
    temporary_storage.exists = false
    fixture.handler.temporary_storage = temporary_storage

    permanent_storage = FileTransferComponent::FileStorage::Permanent::Substitute.new
    permanent_storage.saved = true
    fixture.handler.permanent_storage = permanent_storage

    fixture.(output: "FileNotFound") do |test|

      test.assert_accepted

      test.assert_attributes_assigned([
        :file_id,
        :user_id,
        :team_id,
        :name,
        :uri,
        :time,
        :source,
        :processed_time
      ])
    end
  end
end
