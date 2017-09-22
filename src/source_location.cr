require "./file"

module Clang
  struct SourceLocation
    def initialize(@location : LibClang::SourceLocation)
    end

    def ==(other : SourceLocation)
      LibClang.equalLocations(self, other) != 0
    end

    def in_system_header?
      LibClang.location_isInSystemHeader(self) == 1
    end

    def from_main_file?
      LibClang.location_isFromMainFile(self) == 1
    end

    def file_location
      LibClang.getFileLocation(self, out file, out line, out column, out offset)
      {file ? File.new(file) : nil, line, column, offset}
    end

    def file_name
      LibClang.getFileLocation(self, out file, nil, nil, nil)
      Clang.string(LibClang.getFileName(file)) if file
    end

    def spelling_location
      LibClang.getSpellingLocation(self, out file, out line, out column, out offset)
      {file ? File.new(file) : nil, line, column, offset}
    end

    def expansion_location
      LibClang.getExpansionLocation(self, out file, out line, out column, out offset)
      {file ? File.new(file) : nil, line, column, offset}
    end

    def instantiation_location
      LibClang.getInstantiationLocation(self, out file, out line, out column, out offset)
      {file ? File.new(file) : nil, line, column, offset}
    end

    def presumed_location
      LibClang.getPresumedLocation(self, out file, out line, out column, out offset)
      {file ? File.new(file) : nil, line, column, offset}
    end

    def to_unsafe
      @location
    end

    def inspect(io)
      io << "<##{self.class.name} "
      to_s(io)
      io << ">"
    end

    def to_s(io)
      file, line, column, _ = file_location
      io << (file.try(&.name) || "??") << ' ' << line << ':' << column
    end
  end
end
