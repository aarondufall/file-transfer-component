module FileTransferComponent
  module Commands
    class Initiate
      include Command

      initializer :file_id, :name, :uri

      def self.build(file_id, name, uri, reply_stream_name: nil)
        instance = new(file_id, name, uri)
        instance.reply_stream_name = reply_stream_name
        instance.configure
        instance
      end

      def self.call(file_id, name, uri, reply_stream_name: nil)
        instance = build(file_id, name, uri, reply_stream_name: reply_stream_name)
        instance.()
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
