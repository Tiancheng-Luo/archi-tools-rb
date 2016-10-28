# frozen_string_literal: true
module Archimate
  module Diff
    class Delete < Difference
      attr_accessor :deleted
      attr_accessor :from_model

      alias from deleted

      def initialize(path, from_model, val)
        super(path)
        @from_model = from_model
        @deleted = val
      end

      def ==(other)
        super && @deleted == other.deleted
      end

      def to_s
        "#{diff_type} #{path}: #{deleted.is_a?(Dry::Struct) ? deleted.describe(to_model) : deleted}"
      end

      def diff_type
        'DELETE:'.red
      end

      def describe
        parent, remaining_path = describeable_parent(from_model)
        s = diff_type
        s += parent.describe(from_model)
        s += " #{remaining_path.light_blue} #{inserted.light_green}" unless remaining_path.empty?
        s
      end
    end
  end
end