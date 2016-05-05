require 'net/http'
require 'nokogiri'
require 'logger'

$logger = Logger.new(STDOUT)
$logger.level = Logger::INFO

def html_response uri
  res = Net::HTTP.get_response uri
  res.body
end

def all_devil_pages base_page

  links = [base_page]

  uri = URI(base_page)
  page = Nokogiri::HTML html_response uri

  while not page.xpath("//div[@id='mw-pages']/a[text()='next 200']").empty? do
    
    link = page.xpath("//div[@id='mw-pages']/a[text()='next 200']")[0]['href']
    relative = URI link
    uri.path = relative.path
    uri.query = relative.query
    $logger.info uri
    links << uri.to_s
    page = Nokogiri::HTML html_response uri

  end

  links

end

def extract_devil_links url

  data = {}

  links = all_devil_pages url

  links.each do |link|

  	response = html_response URI link
    page = Nokogiri::HTML response

    page.xpath( "//div[@id='mw-pages']/div[@class='mw-content-ltr']/table/tr/td" ).collect do |row| 

      row.xpath("ul/li").collect do |item| 
      
        key = item.xpath("a")[0]['title']
        value = item.xpath("a")[0]['href']
        data[key] = value

      end

    end
  
  end

  data

end

url = "http://megamitensei.wikia.com/wiki/Category:Shin_Megami_Tensei_IV_Demons"

devil_hash = extract_devil_links url

$logger.info devil_hash