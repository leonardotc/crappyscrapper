class BaseParser

  def self.add_parser (id, parser)
    @@parser_hash ||= {}
    @@parser_hash[id] = parser
  end

  def self.parser id
    return @@parser_hash[id].new if @@parser_hash.key? id

    default = Object.new
    def default.parse node
      $log.error "Class definition not found, quietly skipping..."
      nil
    end
    default
  end

  def self.inherited subclass
    $log.debug "added parser: #{subclass}"
    self.add_parser( subclass.to_s, subclass )
  end

end