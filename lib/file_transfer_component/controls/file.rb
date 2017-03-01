module FileTransferComponent
  module Controls
    module File
      def self.example
        file = FileTransferComponent::File.build
        file.id = id
        file.name = name
        file
      end

      def self.id
        ID.example
      end

      def self.name
        "some_file_name"
      end

      def self.uri
        "/path/to/some_file"
      end

      module New
        def self.example
          FileTransferComponent::File.build
        end
      end

      module Initiated
        def self.example
          File.example
        end
      end
    end
  end
end
