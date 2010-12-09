module Legalizer
  class Template < Document
    def initialize(options={})
      super(options)
      @source = options[:object]
    end

    def send(request_xml)
      template_guid = self.source["guid"]
      package = @config.connection.request(:get, "/api/templates/#{template_guid}/prepackage.json", @config.token, {})
      package_guid = JSON.parse(package.body)["template"]["guid"]
      response = JSON.parse(@config.connection.request(:post, '/api/templates.json', @config.token, {}, request_xml, { 'Content-Type' => 'application/xml' }).body)
      response["document"]["guid"]
    end
  end
end