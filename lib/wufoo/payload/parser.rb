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
        @form.each do |form_attribute, value|

        end
        @fields['Fields'].each do |field|
          @field = Field.new
          field.each do |attribute, value|
            @field.send "#{attribute.underscore}=", value
            #@field.title.each_with_object({}) {|title, join| join[title.squish.downcase.tr(" ", "_")], = @answers.values_at(@field.id)}
            #@field.each { |title, answer| @field[title] = answer[0] }
          end
          @result[@field.title.squish.downcase.tr(" ", "_")] = @answers.values_at(@field.id)
        end
      end

      private

      def prepare
        @form = MultiJson.decode(@data['FormStructure'])
        @fields = MultiJson.decode(@data['FieldStructure'])
        field_keys = @data.keys.grep (/\AField\d/)
        @answers = field_keys.each_with_object({}) {|keys, answers| answers[keys] = @data.values_at(keys)}
        @answers.each { |field, answer| @answers[field] = answer[0] }
      end

		end

	end
end
