module FileTransferComponent
  module FileStorage
    class Temporary
      def self.configure(receiver)
        receiver.temporary_storage = new
      end

      def exist?(uri)
        ::File.exist?(uri)
      end

      def size?(uri, size_bytes)
        ::File.size(uri) == size_bytes
      end

      class Substitute
        attr_writer :exists
        attr_accessor :size_bytes

        def exist?(uri)
          @exists ||= false
        end

        def size?(uri, size_bytes)
          self.size_bytes == size_bytes
        end
      end
    end
  end
end
