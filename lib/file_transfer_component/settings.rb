module FileTransferComponent
  class Settings < ::Settings
    def self.data_source
      "settings/file_transfer_component.json"
    end

    def self.instance
      @instance ||= build
    end
  end
end
