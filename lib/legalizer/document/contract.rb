module Legalizer
  class Contract < Document
    def initialize(options={})
      super(options)
      @source = options[:object]
    end
  end
end