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
      # @source.guid
    end

    def to_s
      @source.name
      # @source.subject
    end

    def to_struct
      OpenStruct.new @source
    end
  end
end
