class DevilExtractor

  include Helper

  def initialize release_list
    @link_extractor = LinkExtractor.new
    @release_list = release_list
  end

  def extract
    @release_list.each do |url|
      devil_hash = @link_extractor.extract_devil_links url
      enrich_uri_hash!(devil_hash, url)
      extract_table( devil_hash, url )
    end
  end

  def extract_table( devil_hash, url)
    devil_hash.each do |k,v|

      $log.info "Acessing: #{v} for #{k}"
      body = Nokogiri::HTML html_response v
    
      node = extract_node( body,  extract_id(url) ) if body
    
      node ||= nil
    
      extract_data( node, camel_case(extract_id(url)) ) if node
    
    end
  end
  
  def extract_node( html_body, id )
    html_body.xpath("//div[@id='mw-content-text']/h3/span[@id='#{id}']/../following-sibling::table[1]") || 
      html_body.xpath("//div[@id='mw-content-text']/h3/span[@id='#{id}_2']/../following-sibling::table[1]")
  end
  
  def extract_data( node, id )
    BaseParser.parser(id).parse node
  end

  def extract_id(url)
    URI(url).path.split(":").last.gsub(/_[dD]{1}emons/,"") if url
  end

  def camel_case id
    id.gsub("_","")
  end
  
end