require "./source_location"

module Clang
  struct Token
    Kind = LibClang::Kind

    def initialize(@translation_unit : TranslationUnit, @token : LibClang::Token)
    end

    def kind
      LibClang.getTokenKind(self)
    end

    def spelling
      Clang.string(LibClang.getTokenSpelling(@translation_unit, self))
    end

    def location
      SourceLocation.new(LibClang.getTokenLocation(@translation_unit, self))
    end

    def extent
      LibClang.getTokenExtent(@translation_unit, self)
    end

    def to_unsafe
      @token
    end

    def inspect(io)
      io << "<##{self.class.name} kind="
      io << kind
      io << " spelling="
      io << spelling
      io << '>'
    end
  end
end
