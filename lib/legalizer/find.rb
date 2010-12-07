module Legalizer
  class Find < Base
    def contract(contract_id)
      result = JSON.parse(@connection.request(:get, "/api/documents/#{contract_id}.json", @token, {}).body)["document"]
      Legalizer::Contract.new({:config => @config, :object => result})
    end

    def all_contracts
      contracts = []
      result = JSON.parse(@connection.request(:get, '/api/documents.json', @token, {}).body)["page"]["documents"]
      result.each do |contract|
        contracts << Legalizer::Contract.new({:config => @config, :object => contract})
      end
      contracts
    end

    def template(template_id)
      result = JSON.parse(@connection.request(:get, "/api/templates/#{template_id}.json", @token, {}).body)["template"]
      Legalizer::Template.new({:config => @config, :object => result})
    end

    def all_templates
      templates = []
      result = JSON.parse(@connection.request(:get, '/api/templates.json', @token, {}).body)["templates"]
      result.each do |contract|
        templates << Legalizer::Template.new({:config => @config, :object => contract})
      end
      templates
    end
  end
end