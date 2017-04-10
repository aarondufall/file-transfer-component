require_relative '../automated_init'

context "Commands" do
  context "Initate" do
    name = Controls::Commands::Initiate.name
    uri = Controls::Commands::Initiate.uri
    reply_stream = 'some_reply_stream'
    category = 'fileTransfer'

    initiate = Commands::Initiate.build(name, uri, reply_stream_name: reply_stream)

    SubstAttr::Substitute.(:clock, initiate)
    SubstAttr::Substitute.(:write, initiate)

    file_id = initiate.()

    write = initiate.write

    writes = initiate.write.writes do |written|
      written.class.message_type == 'Initiate'
    end

    telemetry_data = writes.first &.data

    message = telemetry_data &.message
    stream_name = telemetry_data &.stream_name
    reply_stream_name = telemetry_data &.reply_stream_name

    context "Writes the initiate command" do
      test "File ID [#{message.file_id}]" do
        assert(message.file_id == file_id)
      end

      test "Name [#{message.name}]" do
        assert(message.name == name)
      end

      test "Stream Name [#{stream_name}]" do
        assert(stream_name == Messaging::Postgres::StreamName.command_stream_name(file_id, category))
      end

      test "Reply Stream Name [#{reply_stream_name}]" do
        assert(reply_stream_name == reply_stream)
      end
    end
  end
end
