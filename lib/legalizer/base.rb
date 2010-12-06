module Legalizer
  class Base
    def initialize(options={})
      if options[:config].is_a? Legalizer::Config
        @config = options[:config]
        @connection = options[:config].connection
        @api_key = options[:config].api_key
        @user = options[:config].user
      else
        @config = Legalizer::Config.new(options)
      end
    end

    def connection
      @config.connection
    end

    def config
      @config
    end

    def templates
      Legalizer::Template.new({:config => @config})
    end

    def contracts
      Legalizer::Contract.new({:config => @config})
    end

    def find
      Legalizer::Find.new({:config => @config})
    end
  end
end