module Fixtures
  class Handler
    include TestBench::Fixture

    initializer :handler, :input_message, rw(:entity)

    def raw_time
      Controls::Time::Processed::Raw.example
    end

    def set_clock_time
      self.clock_time = raw_time
    end

    def clock_time=(val)
      handler.clock.now = val
    end

    def clock_time
      handler.clock.iso8601
    end

    def set_entity
      if !entity.nil?
        handler.store.put(entity.id, entity)
      end
    end

    def set_new_entity_probe
      handler.store.new_entity_probe = proc do |new_entity|
        self.entity = new_entity
      end
    end

    def self.build(handler:, input_message:, entity: nil, record_new_entity: nil)
      record_new_entity ||= false

      instance = new(handler, input_message, entity)

      instance.set_clock_time

      if !entity.nil?
        instance.set_entity
      elsif record_new_entity
        instance.set_new_entity_probe
      end

      instance
    end

    def writes(message_type)
      handler.write.writes do |written|
        written.class.message_type == message_type
      end
    end

    def telemetry_data(message_type)
      writes = writes(message_type)
      writes.first &.data
    end

    def call(output:, &blk)
      context "#{input_message.message_type}" do
        handler.(input_message)

        telemetry_data = telemetry_data(output)

        command_name = output
        output_message = telemetry_data &.message
        stream_name = telemetry_data &.stream_name
        expected_version = telemetry_data &.expected_version
        reply_stream_name = telemetry_data &.reply_stream_name

        fixture = Fixture.new(command_name, output_message, input_message, entity, stream_name, expected_version, reply_stream_name, clock_time)

        if block_given?
          blk.(fixture)
        else
          fixture.assert_default
        end
      end

      context ""

      nil
    end

    class Fixture
      include TestBench::Fixture

      initializer(
        :command_name,
        :output_message,
        :input_message,
        :entity,
        :stream_name,
        :expected_version,
        :reply_stream_name,
        :clock_time
      )

      def entity_sequence
        entity.sequence
      end

      def input_sequence
        input_message.metadata.position
      end

      def output_sequence
        output_message.sequence
      end

      def up_to_date?
        entity.up_to_date?(input_sequence)
      end

      def written?
        !output_message.nil?
      end

      def assert_accepted
        assert_written
        assert_output_processed_time
        assert_attributes_assigned
      end

      def assert_written
        context ""
        context "#{command_name}" do
          test "#{command_name} is written" do
            assert(written?)
          end

          context "[Stream: #{stream_name}]"
          context "[Expected Version: #{expected_version}]" if expected_version
          context "[Reply Stream: #{reply_stream_name}]" if reply_stream_name
        end
      end

      def refute_written
        test "#{command_name} is not written" do
          refute(written?)
        end
      end

      def assert_ignored
        context ""

        assert_current
        refute_written
      end

      def assert_output_processed_time
        context ""
        output_time = output_message.processed_time
        test "Processed time is the clock's time [#{output_time}]" do
          assert(output_time == clock_time)
        end
      end

      def assert_attributes_assigned(attribute_names=nil)
        context ""
        AttributeAssignment.(
          output_message,
          attribute_names
        )
      end

      def assert_attributes_copied(attribute_names=nil)
        context ""
        Fixtures::AttributeEquality.(
          output_message,
          input_message,
          attribute_names,
          description: "Attributes Copied"
        )
      end
    end
  end
end
