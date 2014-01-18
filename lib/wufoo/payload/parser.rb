require 'active_support/core_ext/string'

module Wufoo
	module Payload

		class Parser

      def self.parse(data)
        parser = new(data)
        parser.run
        parser.result
      end

      attr_reader :result

      def initialize(data)
        @data = data
        @result = Payload.new
      end

      def run
        prepare
        @form_structure.each do |form_attribute, value|

        end
        @field_structure['Fields'].each do |field|
          field.each do |attribute, value|
            @field = FieldStructure.new
            @field.send "#{attribute.underscore}=", value
            @field.title.each_with_object({}) {|title, join| join[title.squish.downcase.tr(" ", "_")], = @fields.values_at(@field.id)}
            @field.each { |title, answer| @field[title] = answer[0] }
            @result.merge(@field)
          end
        end
      end

      private

      def prepare
        @form_structure = JSON.parse(@data['FormStructure'])
        @field_structure = JSON.parse(@data['FieldStructure'])
        field_keys = @data.keys.grep (/\AField\d/)
        @fields = field_keys.each_with_object({}) {|keys, responses| responses[keys] = @data.values_at(keys)}
        @fields.each { |field, response| @fields[field] = response[0] }
      end

      def joiner

      end
      #@result is an object and should be a collection object for your payload.
		end

	end
end
