require 'net/http'
require 'nokogiri'

class CustomExtractor

  include Commons

  def init

  end

  def extract_devil_data links
    links.each do |link|
      
      uri = enrich link
      body = html_response uri

    end
  end

  def html_response uri
    res = Net::HTTP.get_response uri
    res.body
  end

  def enrich link
    uri = URI link
    uri.host = base_url

    uri
  end

end
$logger.info devil_hash