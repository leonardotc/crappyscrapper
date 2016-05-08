module Helper
  def html_response uri
    res = Net::HTTP.get_response uri
    res.body
  end

  def enrich_uri( base_url, host_url )
  	host_uri = URI host_url
  	base_uri = URI base_url
  	host_uri.query = base_uri.query
  	host_uri.path = base_uri.path

    host_uri
  end

  def enrich_uri_hash!( uri_hash, host_url )
    uri_hash.each do |k, v|
      uri_hash[k] = enrich_uri( v, host_url )
    end
  end
  
end