require_relative '../../automated_init'

context "Handle Events" do
  context "Accept event" do
    handler = Handlers::Events::Initiated.build
    SubstAttr::Substitute.(:write, handler)
    SubstAttr::Substitute.(:store, handler)
    SubstAttr::Substitute.(:clock, handler)
    SubstAttr::Substitute.(:remote_storage, handler)

    fixture = Fixtures::Handler.build(
      handler: handler,
      input_message: Controls::Events::Initiated.example,
      entity: Controls::File::Initiated.example
    )

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
