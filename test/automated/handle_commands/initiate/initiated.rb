require_relative '../../automated_init'

context "Handle Commands" do
  context "Accept command" do
    fixture = Fixtures::Handler.build(
      handler: Handlers::Commands.new,
      input_message: Controls::Commands::Initiate.example,
      record_new_entity: false
    )

    fixture.(output: "Initiated") do |test|

      test.assert_accepted

      test.assert_attributes_copied([
        :file_id,
        :name,
        :uri,
        :time
      ])
    end
  end
end
