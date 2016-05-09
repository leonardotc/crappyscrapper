class ShinMegamiTenseiIV < BaseParser

  def parse node
  	require 'pp'
    result_hash = {}
    node.xpath("tr/td/table/tr/td/table/tr/td").each do |el|

      el.xpath("table/tr").each do |stat|
        pp [ :stat => { :name => stat.xpath("td[1]/text()").to_s.strip , :value => stat.xpath("td[2]/text()").to_s.strip ] ]
      end
      
    end

  end

end