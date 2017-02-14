require_relative '../../automated_init'

context "Handle Events" do
  context "Accept event" do
    fixture = Fixtures::Handler.build(
      handler: Handlers::Events::Initiated.new,
      input_message: Controls::Events::Initiated.example,
      entity: Controls::File::Initiated.example
    )

    #TODO find out how to configure this correctly
    FileTransferComponent::Settings.instance.set fixture.handler

    remote_storage = FileTransferComponent::FileStorage::Remote::Substitute.new
    fixture.handler.remote_storage = remote_storage

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
end
