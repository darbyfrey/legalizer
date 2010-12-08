module Legalizer
  class Template < Document
    def initialize(options={})
      super(options)
      @source = options[:object]
    end

    def send(subject, sender_name, sender_email, recipient_name, recipient_email, tag, callback_url)
      template_guid = self.source["guid"]
      package = @config.connection.request(:get, "/api/templates/#{template_guid}/prepackage.json", @config.token, {})
      package_guid = JSON.parse(package.body)["template"]["guid"]
      xml = build_xml(package_guid, subject, sender_name, sender_email, recipient_name, recipient_email, tag, callback_url)
      response = JSON.parse(@config.connection.request(:post, '/api/templates.json', @config.token, {}, xml, { 'Content-Type' => 'application/xml' }).body)
      response["document"]["guid"]
    end

    private
      def build_xml(guid, subject, sender_name, sender_email, recipient_name, recipient_email, tag, callback_url)
        "<template>
          <guid>#{guid}</guid>
          <subject>#{subject}</subject>
          <action>send</action>
          <roles>
            <role role_name='Document Sender'>
                <name>#{sender_name}</name>
                <email>#{sender_email}</email>
            </role>
            <role role_name='Client'>
                <name>#{recipient_name}</name>
                <email>#{recipient_email}</email>
            </role>
          </roles>
          <tags>
              <tag>
                  <value>#{tag}</value>
              </tag>
          </tags>
          <callback_location>#{callback_url}</callback_location>
        </template>"
      end
  end
end