require "wufoo/payload/version"

module Wufoo
  module Payload
    def self.parse(data)
      Parser.parse(data)
    end
  end
end
