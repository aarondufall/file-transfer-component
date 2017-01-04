puts RUBY_DESCRIPTION

require_relative 'logger_settings'

require_relative '../init.rb'

require 'test_bench'; TestBench.activate

require 'file_transfer_component/controls'

require 'pp'

require_relative 'fixtures/attribute_equality'
require_relative 'fixtures/attribute_assignment'
require_relative 'fixtures/handler'

include FileTransferComponent
