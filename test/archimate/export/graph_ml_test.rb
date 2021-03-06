# frozen_string_literal: true
require 'test_helper'

module Archimate
  module Export
    class GraphMLTest < Minitest::Test
      def test_graphml
        p1 = build_property
        p2 = build_property
        model = build_model(with_relationships: 2, with_diagrams: 2, with_elements: 4, with_organizations: 4, property_definitions: [p1.property_definition, p2.property_definition])
        model.elements.first.properties << p1 << p2
        model.elements.first.documentation = build_documentation
        subject = GraphML.new(model)

        result = subject.to_graphml

        doc = Nokogiri::XML(result)
        refute_nil doc
      end
    end
  end
end
