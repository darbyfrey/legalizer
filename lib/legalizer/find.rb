module Legalizer
  class Find < Base
    def contract(contract_id)
      contract = @connection.getDocumentInfo(:apiKey => @api_key, :documentKey => contract_id).documentInfo
      Legalizer::Document.new({:config => @config, :object => contract})
    end

    def all_contracts
      contracts = []
      result = @connection.getDocumentsForUser(:apiKey => @api_key, :userKey => @user[:user_id]).getDocumentsForUserResult.documentListForUser.documentListItem
      if result.is_a? Array
        result.each do |contract|
          contracts << Legalizer::Contract.new({:config => @config, :object => contract})
        end
      else
        contracts << Legalizer::Contract.new({:config => @config, :object => result})
      end
      contracts
    end

    def template(template_id)
      raise 'implement'
    end

    def all_templates
      templates = []
      result = @connection.getLibraryDocumentsForUser(:apiKey => @api_key, :userCredentials => @user).getLibraryDocumentsForUserResult.libraryDocuments.documentLibraryItem
      if result.is_a? Array
        result.each do |template|
          templates << Legalizer::Template.new({:config => @config, :object => template})
        end
      else
        templates << Legalizer::Template.new({:config => @config, :object => result})
      end
      templates
    end
  end
end