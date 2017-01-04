module FileTransferComponent
  module Controls
    module ID
      def self.example(increment: nil)
        Identifier::UUID::Controls::Incrementing.example(increment: increment)
      end
    end
  end
end
