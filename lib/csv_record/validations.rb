module CsvRecord
  module Validations
    module ClassMethods
      attr_accessor :errors, :fields_to_validate

      def __validates_presence_of__(*attr_names)
        @fields_to_validate = attr_names
      end

      alias :validates_presence_of :__validates_presence_of__
    end

    module InstanceMethods
      def __valid__?
        if self.class.fields_to_validate
          validate_each(self.class.fields_to_validate)
        else
          true
        end
      end

      def invalid?
        not self.__valid__?
      end

      alias :valid? :__valid__?

      private
      def validate_each(attrs)
        attrs.collect.none? { |attr| self.public_send(attr).nil? }
      end
    end
  end
end