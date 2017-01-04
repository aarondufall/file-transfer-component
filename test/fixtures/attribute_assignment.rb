module Fixtures
  class AttributeAssignment
    include TestBench::Fixture

    attr_reader :schema
    attr_accessor :attribute_names
    attr_accessor :verbose

    def initialize(schema)
      @schema = schema
    end

    def self.call(schema, attribute_names=nil, verbose: nil)
      instance = new(schema)
      instance.attribute_names = attribute_names
      instance.verbose = verbose
      instance.()
    end

    def call
      self.attribute_names ||= schema.class.attribute_names
      self.attribute_names = Array(attribute_names)
      self.verbose ||= false

      env_verbose = ENV['VERBOSE']
      unless env_verbose.nil?
        verbose = true unless ['off', 'false'].include?(env_verbose)
      end

      control = schema.class.new

      schema_class_name = schema.class.name.split('::').last

      schema = self.schema

      context "Attributes Assigned [#{schema_class_name}]" do
        attribute_names.each do |attribute_name|

          display_attribute_name = attribute_name.to_s
          display_attribute_name.gsub!('{', '')
          display_attribute_name.gsub!('}', '')

          default_value = control.public_send(attribute_name)
          assigned_value = schema.public_send(attribute_name)

          context "#{display_attribute_name} [Assigned: #{assigned_value.inspect}, Default: #{default_value.inspect}]" do
            refute(assigned_value == default_value)
          end
        end
      end

      if verbose
        pp schema
        pp control
      end
    end
  end
end
