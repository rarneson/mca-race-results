require_relative 'y2024_parsers/brophy_park_2024_parser'
require_relative 'y2024_parsers/lake_rebecca_2024_parser'
require_relative 'y2024_parsers/gamehaven_2024_parser'
require_relative 'y2024_parsers/mt_kato_2024_parser'
require_relative 'y2024_parsers/theodore_wirth_2024_parser'
require_relative 'y2024_parsers/pine_valley_2024_parser'
require_relative 'y2024_parsers/redhead_2024_parser'

module RaceData
  class ParserFactory
    PARSERS = [
      BrophyPark2024Parser,
      LakeRebecca2024Parser,
      Gamehaven2024Parser,
      MtKato2024Parser,
      TheodoreWirth2024Parser,
      PineValley2024Parser,
      Redhead2024Parser
    ].freeze

    def self.create_parser(pdf_path)
      # Extract text once for format detection
      text = extract_text_for_detection(pdf_path)
      
      # Find the first parser that can handle this format
      parser_class = PARSERS.find { |klass| klass.new(pdf_path).can_parse?(text) }
      
      if parser_class
        parser_class.new(pdf_path)
      else
        raise UnsupportedFormatError, "No parser found for PDF format in #{pdf_path}"
      end
    end

    private

    def self.extract_text_for_detection(pdf_path)
      require 'pdf/reader'
      reader = PDF::Reader.new(pdf_path)
      text = ""
      reader.pages.each do |page|
        text += page.text
      end
      text
    end
  end

  class UnsupportedFormatError < StandardError; end
end