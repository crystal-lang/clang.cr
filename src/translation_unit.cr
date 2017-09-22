require "./token"

module Clang
  class TranslationUnit
    alias Options = LibClang::TranslationUnit_Flags

    def self.default_options
      LibClang.defaultEditingTranslationUnitOptions() |
        Options::DetailedPreprocessingRecord
    end

    def self.from_pch(index, path)
      error_code = LibClang.createTranslationUnit2(index, path, out unit)
      raise Error.from(error_code) unless error_code.success?
      new(unit)
    end

    def self.from_source(index,
                         files : Array(UnsavedFile),
                         args = [] of String,
                         options = default_options,
                         filename = files[0].filename)
      error_code = LibClang.parseTranslationUnit2(
        index, filename,
        args.map(&.to_unsafe), args.size,
        files.map(&.to_unsafe), files.size,
        options, out unit)
      raise Error.from(error_code) unless error_code.success?
      new(unit)
    end

    def self.from_source_file(index, path, args = [] of String)
      new LibClang.createTranslationUnitFromSourceFile(index, path, args.size, args.map(&.to_unsafe), 0, nil)
    end

    protected def initialize(@unit : LibClang::TranslationUnit)
      raise "invalid translation unit pointer" unless @unit
    end

    def finalize
      LibClang.disposeTranslationUnit(self)
    end

    def cursor
      Cursor.new LibClang.getTranslationUnitCursor(self)
    end

    def multiple_include_guarded?(file : File)
      LibClang.isFileMultipleIncludeGuarded(self, file) == 1
    end

    def tokenize(source_range, skip = 0)
      LibClang.tokenize(self, source_range, out tokens, out count)
      begin
        skip.upto(count - 1) do |index|
          yield Token.new(self, tokens[index])
        end
      ensure
        LibClang.disposeTokens(self, tokens, count)
      end
    end

    def to_unsafe
      @unit
    end
  end
end
