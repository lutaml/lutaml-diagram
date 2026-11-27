# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "lutaml/diagram/version"

Gem::Specification.new do |spec|
  spec.name = "lutaml-diagram"
  spec.version = Lutaml::Diagram::VERSION
  spec.authors = ["Ribose Inc."]
  spec.email = ["open.source@ribose.com"]

  spec.summary = "Diagram rendering for the LutaML Model Language"
  spec.description = "Graphviz, ELK and SVG/PDF render backends, layout " \
                     "engines and the lutaml-lml CLI for the LutaML Model " \
                     "Language. The language core lives in lutaml-model."
  spec.homepage = "https://github.com/lutaml/lutaml-diagram"
  spec.license = "BSD-2-Clause"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["rubygems_mfa_required"] = "true"

  # The LML language core (parser, model compiler, executor, LML seam
  # namespaces) ships in lutaml-model from 0.8.188 (the lutaml-lml
  # subsume); this gem reopens Lutaml::Formatter and Lutaml::Layout
  # with the render backends and ships the CLI.
  spec.add_dependency "lutaml-model", "~> 0.8.188"
  spec.add_dependency "elkrb", "~> 2.0"
  spec.add_dependency "thor"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
