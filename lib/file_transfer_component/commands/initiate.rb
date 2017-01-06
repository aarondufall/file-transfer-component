module FileTransferComponent
  module Commands
    class Initiate
      include Command

      initializer :file_id, :name, :uri

      def self.build(name, uri, reply_stream_name: nil)
        file_id = Identifier::UUID::Random.get
        instance = new(file_id, name, uri)
        instance.reply_stream_name = reply_stream_name
        instance.configure
        instance
      end

      def self.call(name, uri, reply_stream_name: nil)
        instance = build(name, uri, reply_stream_name: reply_stream_name)
        instance.()
        instance.file_id
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
