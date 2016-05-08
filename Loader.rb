require 'net/http'
require 'nokogiri'
require 'logger'
require './Helper.rb'
require './LinkExtractor.rb'
require './DevilExtractor.rb'
require './BaseParser.rb'

$log = Logger.new STDOUT
$log.level = Logger::INFO

Dir["#{File.dirname(__FILE__)}/parsers/*.rb"].each {|file| require file }

links = []

extractor = DevilExtractor.new ["http://megamitensei.wikia.com/wiki/Category:Shin_Megami_Tensei_IV_Demons"]
extractor.extract 