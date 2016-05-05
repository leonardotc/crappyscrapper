require 'net/http'
require 'nokogiri'

class Scrapper

  release_list.each do |k,v|

    body = Net:HTTP.get_response(v)
    
    node = extract_node( body, k ) if body
    
    node ||= nil
    
    extract_data( node, id ) if node
    
  end
  
  def extract_node( html_body, id )
    html_body.xpath("//div[@id='mw-content-text']/h3/span[@id='#{id}']/../following-sibling::table[1]")
  end
  
  def extract_data( node, id )
    @strategist[id].extract_data node if @strategist.has_key? id
  end
  
end