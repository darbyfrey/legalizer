module Legalizer
  class Contract < Document
    def initialize(options={})
      super(options)
      @source = options[:object]
    end

    def info
      contract = {
        :date => @source.displayDate,
        :contract_id => @source.documentKey,
        :esign => @source.esign,
        :mega_sign => @source.megaSign,
        :contract_name => @source.name,
        :status => @source.userDocumentStatus,
        :company => @source.displayUserInfo.company,
        :name => @source.displayUserInfo.fullNameOrEmail
      }
      OpenStruct.new contract
    end

    def details
      result = @connection.getDocumentInfo(:apiKey => @api_key, :documentKey => self.id).documentInfo
      events = []
      result.events.documentHistoryEvent.each do |e|
        events << {
          :date => e.date,
          :description => e.description,
          :version_id => (e.documentVersionKey if e.documentVersionKey.is_a? String)
        }
      end
      
      contract = {
        :contract_id => result.latestDocumentKey,
        :contract_name => result.name,
        :status => result.status,
        :locale => result.locale,
        :events => events
      }
      OpenStruct.new contract
    end
  end
end