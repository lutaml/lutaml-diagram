# frozen_string_literal: true

require "lutaml/model"

module Lutaml
  # Diagram rendering for the LutaML Model Language: the Graphviz, ELK
  # and SVG/PDF formatters, the layout engines, and the `lutaml-lml`
  # CLI. The LML language core itself lives in lutaml-model
  # (`Lutaml::Lml`); this gem reopens the same seam namespaces and
  # ships the render backends against it.
  module Diagram
  end
end

require "lutaml/lml"

module Lutaml
  # Render formatters (Graphviz, ELK, SVG/PDF) alongside the core's
  # Base and Canonical.
  module Formatter
    autoload :Base, "lutaml/lml/formatter/base"
    autoload :Graphviz, "lutaml/lml/formatter/graphviz"
    autoload :Elk, "lutaml/lml/formatter/elk"
    autoload :SvgPdf, "lutaml/lml/formatter/svg_pdf"
    autoload :Canonical, "lutaml/lml/formatter/canonical"
  end

  # Layout engines (GraphViz, ELK) against the core's Engine seam.
  module Layout
    autoload :Engine, "lutaml/lml/layout/engine"
    autoload :GraphVizEngine, "lutaml/lml/layout/graph_viz_engine"
    autoload :ElkEngine, "lutaml/lml/layout/elk_engine"
    autoload :ElkGraphBuilder, "lutaml/lml/layout/elk_graph_builder"
    autoload :ElkSvgRenderer, "lutaml/lml/layout/elk_svg_renderer"
    autoload :ElkSvgMarkers, "lutaml/lml/layout/elk_svg_markers"
  end
end

require "lutaml/lml/cli"
