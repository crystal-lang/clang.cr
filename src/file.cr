module Clang
  struct File
    def initialize(@file : LibC::CXFile)
    end

    def ==(other : File)
      LibC.clang_file_isEqual(self, other) != 0
    end

    def ==(other)
      false
    end

    def name
      Clang.string(LibC.clang_getFileName(self))
    end

    def time
      Time.epoch(LibC.clang_getFileTime(self))
    end

    def unique_id
      ret = LibC.clang_getFileUniqueID(self, out uid)
      raise Error.new("clang_getFileUniqueID failure") unless ret == 0
      uid
    end

    def to_unsafe
      @file
    end
  end
end
