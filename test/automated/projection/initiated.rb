require_relative '../automated_init'

context "File Projection" do
  fixture = Fixtures::Projection.build(
    projection: Projection,
    entity: Controls::File::New.example,
    event: Controls::Events::Initiated.example
  )

  fixture.() do |test|
    test.assert_attributes_copied([
      {file_id: :id},
      :name,
    ])

    test.assert_time_converted_and_copied(:processed_time, :initiated_time)
  end
end
