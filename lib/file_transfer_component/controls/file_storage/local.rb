module FileTransferComponent
  module Controls
    module FileStorage
      module Local
        def self.example
          temp_file = Tempfile.new('some_file')
          temp_file.write("some file contents")
          temp_file.close
          temp_file
        end 
        module Path
          def self.not_found
            "/file/not/at/path"
          end
        end
      end
    end
  end
end
