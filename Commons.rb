require 'net/http'
require 'nokogiri'
require 'logger'

$logger = Logger.new(STDOUT)
$logger.level = Logger::INFO

module Commons

  def html_response uri
    res = Net::HTTP.get_response uri
    res.body
  end

end
