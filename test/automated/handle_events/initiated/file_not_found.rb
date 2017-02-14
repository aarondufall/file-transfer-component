require_relative '../../automated_init'

context "Handle Events" do
  context "File Not Found" do
    handler = Handlers::Events::Initiated.build
    SubstAttr::Substitute.(:write, handler)
    SubstAttr::Substitute.(:store, handler)
    SubstAttr::Substitute.(:clock, handler)

    fixture = Fixtures::Handler.build(
      handler: handler,
      input_message: Controls::Events::Initiated.example,
      entity: Controls::File::Initiated.example
    )


    remote_storage = FileTransferComponent::FileStorage::Remote::Substitute.new
    remote_storage.not_found = true;

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
