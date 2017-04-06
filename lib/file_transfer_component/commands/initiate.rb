module FileTransferComponent
  module Commands
    class Initiate
      include Command
      attr_writer :file_id

      initializer :name, :uri

      def self.build(name, uri, file_id: nil, reply_stream_name: nil)
        instance = new(name, uri)
        instance.file_id = file_id
        instance.reply_stream_name = reply_stream_name
        instance.configure
        instance
      end

      def self.call(name, uri, file_id: nil, reply_stream_name: nil)
        instance = build(name, uri, file_id: file_id, reply_stream_name: reply_stream_name)
        instance.()
      end

      def file_id
        @file_id ||= identifier.get
      end

      def call
        write_command
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
