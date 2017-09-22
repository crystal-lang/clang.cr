module Clang
  struct File
    def initialize(@file : LibClang::File)
    end

    def ==(other : File)
      LibClang.file_isEqual(self, other) != 0
    end

    def ==(other)
      false
    end

    def name
      Clang.string(LibClang.getFileName(self))
    end

    def time
      Time.epoch(LibClang.getFileTime(self))
    end

    def unique_id
      ret = LibClang.getFileUniqueID(self, out uid)
      raise Error.new("clang_getFileUniqueID failure") unless ret == 0
      uid
    end

    def to_unsafe
      @file
    end
  end
end
