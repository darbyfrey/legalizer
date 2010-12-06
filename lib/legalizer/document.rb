module Legalizer
  class Document < Base
    def initialize(options={})
      super(options)
      @source = options[:object]
    end

    def source
      @source
    end

    def id
      @source.documentKey
    end

    def to_s
      @source.name
    end
  end
end
