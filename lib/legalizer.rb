$:.unshift(File.dirname(__FILE__)) unless
$:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
require 'soap/wsdlDriver'
require 'ostruct'

module Legalizer
  VERSION = '0.0.1'
end

require 'legalizer/base'
require 'legalizer/config'
require 'legalizer/find'
require 'legalizer/document'
require 'legalizer/document/template'
require 'legalizer/document/contract'

def Legalizer(options={})
  Legalizer::Base.new(options)
end