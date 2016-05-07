require 'net/http'
require 'nokogiri'
require 'logger'

$log = Logger.new STDOUT
$log.level = Logger::INFO

Dir["#{File.dirname(__FILE__)}/*.rb"].each {|file| require file }

links = []

extractor = LinkExtractor.new
extractor.extract_devil_links "http://megamitensei.wikia.com/wiki/Category:Shin_Megami_Tensei_IV_Demons"