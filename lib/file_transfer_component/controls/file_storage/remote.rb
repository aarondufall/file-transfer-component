module FileTransferComponent
  module Controls
    module FileStorage
      module Remote
        module Key
          def self.example
            "/test/someKey-#{SecureRandom.hex 7}"
          end 
        end
      end
    end
  end
end
