require_relative '../../automated_init'

# context "Handle Commands" do
#   context "Accept command" do
#     fixture = Fixtures::Handler.build(
#       handler: Handlers::Commands.new,
#       input_message: Controls::Commands::Initiate.example,
#       record_new_entity: false
#     )

#     fixture.(output: "Initiated") do |test|

#       test.assert_accepted

#       test.assert_attributes_copied([
#         :file_id,
#         :name,
#         :uri,
#         :time
#       ])
#     end
#   end
# end


context "Handle Commands" do
  handler = Handlers::Commands.new

  clock_time = Controls::Time::Raw.example
  time = Controls::Time::ISO8601.example(clock_time)

  handler.clock.now = clock_time

  initiate = Controls::Commands::Initiate.example
  handler.(initiate)

  context "Initiate" do
    writes = handler.write.writes do |written_event|
      written_event.class.message_type == "Initiated"
    end

    initiated = writes.first.data.message

    test "Initiated event is written" do
      refute(initiated.nil?)
    end

    context "Recorded Attributes" do
      Fixtures::AttributeEquality.(
        initiated,
        initiate,
        [
          :file_id,
          :name,
          :uri,
          :time
        ]
      )

      test "No Unset Attributes" do
        initiated.class.attribute_names.each do | attribute |
          refute(initiated.public_send(attribute).nil?)
        end
      end
    end
  end
end
