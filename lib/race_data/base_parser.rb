module RaceData
  class BaseParser
    def initialize(pdf_path)
      @pdf_path = pdf_path
    end

    def can_parse?(text)
      raise NotImplementedError, "Subclasses must implement can_parse?"
    end

    def extract_race_data
      raise NotImplementedError, "Subclasses must implement extract_race_data"
    end

    protected

    def extract_text
      require 'pdf/reader'
      reader = PDF::Reader.new(@pdf_path)
      text = ""
      reader.pages.each do |page|
        text += page.text
      end
      text
    end
  end
end