module Fixtures
  class AttributeEquality
    include TestBench::Fixture

    attr_reader :compare
    attr_reader :control
    attr_accessor :attribute_names
    attr_accessor :verbose
    attr_writer :description

    def description
      @description ||= "Attribute Equality"
    end

    def initialize(compare, control)
      @compare = compare
      @control = control
    end

    def self.call(compare, control, attribute_names=nil, verbose: nil, description: nil)
      instance = new(compare, control)
      instance.attribute_names = attribute_names
      instance.verbose = verbose
      instance.description = description
      instance.()
    end

    def call
      self.attribute_names ||= compare.class.attribute_names
      self.attribute_names = Array(attribute_names)
      self.verbose ||= false

      env_verbose = ENV['VERBOSE']
      unless env_verbose.nil?
        verbose = true unless ['off', 'false'].include?(env_verbose)
      end

      control_class_name = control.class.name.split('::').last
      compare_class_name = compare.class.name.split('::').last

      control = self.control

      context "#{description} [#{control_class_name} -> #{compare_class_name}]" do
        attribute_names.each do |attribute|

          if attribute.is_a? Hash
            control_attribute, compare_attribute = attribute.keys.first, attribute.values.first
          else
            control_attribute, compare_attribute = attribute, attribute
          end

          control_attribute_value = control.public_send(control_attribute)
          compare_attribute_value = compare.public_send(compare_attribute)

          display_attribute_value = "#{control_attribute_value.inspect} -> #{compare_attribute_value.inspect}"

          display_attribute_name = attribute.to_s
          display_attribute_name.delete!(':{}')
          display_attribute_name.gsub!('=>', ' -> ')

          context "#{display_attribute_name} [#{display_attribute_value}]" do
            assert(compare_attribute_value == control_attribute_value)
          end
        end
      end

      if verbose
        pp compare
        pp control
      end
    end
  end
end
