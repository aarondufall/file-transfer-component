require_relative 'automated_init'

context "Database Connection" do
  session = EventSource::Postgres::Session.build

  refute(session.connected?)

  test "Connects on first use" do
    refute proc { session.execute('SELECT 1;') } do
      raises_error?
    end
  end
end
