require "./lib_clang"
require "./index"
require "./translation_unit"
require "./cursor"
require "./type"
require "./unsaved_file"
require "./source_location"

module Clang
  class Error < Exception
    alias Code = LibC::CXErrorCode

    def self.from(code : Code)
      new code.to_s
    end
  end

  # Make a `String` from a `LibC::CXString` then disposes the latter unless
  # *dispose* is false.
  def self.string(str : LibC::CXString, dispose = true)
    String.new(LibC.clang_getCString(str))
  ensure
    LibC.clang_disposeString(str) if dispose
  end
end
