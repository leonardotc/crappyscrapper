class LinkExtractor

  include Helper

  def all_devil_pages base_page

    links = [base_page]
    uri = URI(base_page)
    page = Nokogiri::HTML html_response uri

    while not page.xpath("//div[@id='mw-pages']/a[text()='next 200']").empty? do
    
      link = page.xpath("//div[@id='mw-pages']/a[text()='next 200']").first['href']
      relative = URI link
      uri.path = relative.path
      uri.query = relative.query
      $log.info uri.to_s
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

end