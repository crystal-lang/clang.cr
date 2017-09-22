require "./lib_clang"
require "./index"
require "./translation_unit"
require "./cursor"
require "./type"
require "./unsaved_file"
require "./source_location"

module Clang
  class Error < Exception
    alias Code = LibClang::ErrorCode

    def self.from(code : Code)
      new code.to_s
    end
  end

  # Make a `String` from a `LibClang::String` then disposes the latter unless
  # *dispose* is false.
  def self.string(str : LibClang::String, dispose = true)
    String.new(LibClang.getCString(str))
  ensure
    LibClang.disposeString(str) if dispose
  end
end
