module C2CR
  module Constant
    def self.to_crystal(spelling)
      case spelling
      when "uint8_t" then "UInt8"
      when "uint16_t" then "UInt16"
      when "uint32_t" then "UInt32"
      when "uint64_t" then "UInt64"
      when .starts_with?("const ")
        spelling[6..-1].camelcase
      else
        spelling.camelcase
      end
    end
  end
end
