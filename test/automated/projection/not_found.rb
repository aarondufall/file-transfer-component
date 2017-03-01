require_relative '../automated_init'

context "File Projection" do
  fixture = Fixtures::Projection.build(
    projection: Projection,
    entity: Controls::File::Initiated.example,
    event: Controls::Events::NotFound.example
  )

  fixture.() do |test|
    test.assert_time_converted_and_copied(:processed_time, :not_found_time)
    #TODO assset for not found
  end
end
