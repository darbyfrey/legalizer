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
      @source["guid"]
    end

    def to_s
      @source["subject"]
    end

    def state
      @source["state"]
    end
  end
end
