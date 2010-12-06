module Legalizer
  class Template < Document
    def initialize(options={})
      super(options)
      @source = options[:object]
    end

    def info
      template = {
        :name => @source.name,
        :template_id => @source.documentKey,
        :updated_at => @source.modifiedDate,
        :scope => @source.scope
      }
      OpenStruct.new template
    end
  end
end