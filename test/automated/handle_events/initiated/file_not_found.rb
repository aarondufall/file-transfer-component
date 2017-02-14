require_relative '../../automated_init'

context "Handle Events" do
  context "File Not Found" do
    fixture = Fixtures::Handler.build(
      handler: Handlers::Events::Initiated.new,
      input_message: Controls::Events::Initiated.example,
      entity: Controls::File::Initiated.example
    )

    #TODO make substitute and remove setting
    FileTransferComponent::Settings.instance.set fixture.handler

    remote_storage = FileTransferComponent::FileStorage::Remote.new


    fixture.handler.remote_storage = remote_storage

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
