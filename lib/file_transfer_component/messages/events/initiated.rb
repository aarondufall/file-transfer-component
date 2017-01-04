module FileTransferComponent
  module Messages
    module Events
      class Initiated
        include Messaging::Message

        attribute :file_id, String
        attribute :user_id, String
        attribute :team_id, String
        attribute :name, String
        attribute :uri, String
        attribute :time, String
        attribute :source, String
        attribute :processed_time, String
      end
    end
  end
end

# {"id"=>"4334823f-69a9-4630-bc50-56bdedcf1547", "file"=>{:filename=>"test.pdf", :type=>"application/pdf", :name=>"file", :tempfile=>#<Tempfile:/var/folders/3z/f8gx2c5n2d9b5gqmbbw_r_fr0000gn/T/RackMultipart20161226-60650-1hnx8q9.pdf>, :head=>"Content-Disposition: form-data; name=\"file\"; filename=\"test.pdf\"\r\nContent-Type: application/pdf\r\n"}, "userId"=>"f8b53537-f3bb-41af-946e-ac5b6cbf965a", "source"=>"web", "splat"=>[], "captures"=>["4334823f-69a9-4630-bc50-56bdedcf1547"]}
