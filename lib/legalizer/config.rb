module Legalizer
  class Config
    attr_reader :connection, :token
    def initialize(options={})
      @connection = OAuth::Consumer.new(options[:oauth_key], options[:oauth_secret], {
        :site               => "https://rightsignature.com",
        :scheme             => :header,
        :http_method        => :post,
        :request_token_path => "/oauth/request_token",
        :access_token_path  => "/oauth/access_token",
        :authorize_path     => "/oauth/authorize"
      })
      
      @token = OAuth::Token.new(options[:access_token], options[:access_secret])
    end
  end
end
