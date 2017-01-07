module FileTransferComponent
  module Commands
    class Initiate
      include Command
      attr_writer :file_id

      initializer :name, :uri

      def self.build(name, uri, reply_stream_name: nil)
        instance = new(name, uri)
        instance.reply_stream_name = reply_stream_name
        instance.configure
        instance
      end

      def self.call(name, uri, reply_stream_name: nil)
        instance = build(name, uri, reply_stream_name: reply_stream_name)
        instance.()
      end

      def file_id
        @file_id ||= Identifier::UUID::Random.get
      end

      def call
        stream_name = command_stream_name(file_id)
        write.(command, stream_name, reply_stream_name: reply_stream_name)
        file_id
      end

      def command
        Messages::Commands::Initiate.build(
          file_id: file_id, 
          name: name, 
          uri: uri,
          time: clock.iso8601
        )
      end
    end
  end
end
