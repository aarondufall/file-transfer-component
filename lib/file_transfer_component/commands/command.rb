module FileTransferComponent
  module Commands
    module Command
      def self.included(cls)
        cls.class_exec do
          include Messaging::StreamName
          include FileTransferComponent::Messages::Commands
          include FileTransferComponent::Messages::Events
          include Telemetry::Logger::Dependency

          attr_accessor :reply_stream_name

          dependency :write, Messaging::Postgres::Write
          dependency :clock, Clock::UTC

          category :file_transfer
          abstract :command
        end
      end

      def configure
        Messaging::Postgres::Write.configure self
        Clock::UTC.configure self
      end

      def call
        stream_name = command_stream_name(file_id)
        write.(command, stream_name, reply_stream_name: reply_stream_name)
      end
    end
  end
end
