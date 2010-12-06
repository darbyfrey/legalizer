module Legalizer
  class Config
    attr_reader :api_key, :connection, :user
    def initialize(options={})
      options[:api_version] = 9 unless options[:api_version]
      url = "https://secure.echosign.com/services/EchoSignDocumentService#{options[:api_version]}?WSDL"
      factory = SOAP::WSDLDriverFactory.new(url)
      @api_key = options[:api_key]
      @connection = factory.create_rpc_driver
      @user = {:email => options[:email], :password => options[:password], :user_id => find_user_id(options[:email])}
    end

    private
      def find_user_id(email)
        result = @connection.getUsersInAccount(:apiKey => @api_key).getUsersInAccountResult.userListForAccount.userInfo
        if result.is_a? Array
          result.each do |u|
            if u.email == email
              return u.userKey
            end
          end
          return nil
        else
          if result.email == email
            return result.userKey
          else
            return nil
          end
        end
      end
  end
end