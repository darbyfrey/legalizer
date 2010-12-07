module Legalizer
  class ConfigureOAuth
    def initialize(options={})
      @connection = OAuth::Consumer.new(options[:oauth_key], options[:oauth_secret], {
        :site               => "https://rightsignature.com",
        :scheme             => :header,
        :http_method        => :post,
        :request_token_path => "/oauth/request_token",
        :access_token_path  => "/oauth/access_token",
        :authorize_path     => "/oauth/authorize"
      })

      request_token = @connection.get_request_token(:oauth_callback => "http://localhost:3000/callback")
      puts "Now visit:\n#{request_token.authorize_url}\n..."
      puts "What's the value of `oauth_verifier`?"
      oauth_verifier = gets.chomp
      access_token = request_token.get_access_token(:oauth_verifier => oauth_verifier)
      puts "Your access token is: #{access_token.token}\n"
      puts "Your access secret is: #{access_token.secret}\n"
      puts "Now you're ready to use these 2 values in your Legalizer configuration\n\n\n"
    end
  end
end