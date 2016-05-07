require 'net/http'
require 'nokogiri'

class CustomExtractor

  include Helper

  def init

  end

  def extract_devil_data links
    links.each do |link|
      
      uri = enrich link
      body = html_response uri

    end
  end

  def enrich link
    uri = URI link
    uri.host = base_url

    uri
  end

end