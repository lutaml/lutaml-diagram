# frozen_string_literal: true

require 'set'

module Lutaml
  module Formatter
    # Emits Graphviz DOT source for LML diagrams. Pure text generation —
    # no graphviz binary, no ruby-graphviz: rendering the emitted DOT
    # rides etassia's pure-Ruby DOT support (etassia#497) or an external
    # renderer at the consumer's discretion.
    class Graphviz < Base
      autoload :HtmlBuilder, "lutaml/lml/formatter/graphviz/html_builder"
      autoload :NodeFormatter, "lutaml/lml/formatter/graphviz/node_formatter"
      autoload :RelationshipFormatter, "lutaml/lml/formatter/graphviz/relationship_formatter"
      autoload :DocumentFormatter, "lutaml/lml/formatter/graphviz/document_formatter"

      include HtmlBuilder
      include NodeFormatter
      include RelationshipFormatter
      include DocumentFormatter

      class Attributes < Hash
        def to_s
          to_a
            .reject { |(_k, val)| val.nil? }
            .map { |(a, b)| "#{a}=#{b.inspect}" }
            .join(' ')
        end
      end

      DEFAULT_CLASS_FONT = 'Helvetica'

      # Output formats: DOT source today; SVG (and friends) once etassia
      # lands DOT rendering (etassia#497).
      VALID_TYPES = %i[dot].freeze

      def initialize(attributes = {})
        super
        setup_default_attributes
        @type = :dot
      end

      attr_reader :graph, :edge, :node

      def type=(value)
        super
        @type = :dot unless VALID_TYPES.include?(@type)
      end

      def format(node)
        dot = super.lines.map(&:rstrip).join("\n")
        generate_from_dot(dot)
      end

      def setup_default_attributes
        @graph = build_graph_attrs
        @edge = build_edge_attrs
        @node = build_node_attrs
      end

      def build_graph_attrs
        Attributes.new.tap do |g|
          g['splines'] = 'ortho'
          g['pad'] = '0.5'
          g['ranksep'] = '1.2'
          g['nodesep'] = '1.2'
          g['rankdir'] = 'BT'
        end
      end

      def build_edge_attrs
        Attributes.new.tap { |e| e['color'] = 'gray50' }
      end

      def build_node_attrs
        Attributes.new.tap { |n| n['shape'] = 'box' }
      end

      private :setup_default_attributes, :build_graph_attrs,
              :build_edge_attrs, :build_node_attrs

      protected

      def generate_from_dot(input)
        input
      end

      def generate_graph_name(name)
        name.gsub(/[^0-9a-zA-Z]/i, '')
      end
    end
  end
end
