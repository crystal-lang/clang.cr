module Clang
  alias EvalResultKind = LibC::CXEvalResultKind

  class EvalResult
    def initialize(@result : LibC::CXEvalResult)
    end

    def kind
      LibC.clang_EvalResult_getKind(self)
    end

    def as_int
      LibC.clang_EvalResult_getAsInt(self)
    end

    def unsigned?
      LibC.clang_EvalResult_isUnsignedInt(self) != 0
    end

    def as_unsigned
      LibC.clang_EvalResult_getAsUnsigned(self)
    end

    def as_long_long
      LibC.clang_EvalResult_getAsLongLong(self)
    end

    def as_double
      LibC.clang_EvalResult_getAsDouble(self)
    end

    def as_str
      String.new(LibC.clang_EvalResult_getAsStr(self))
    end

    def finalize
      LibC.clang_EvalResult_dispose(self)
    end

    def to_unsafe
      @result
    end
  end
end
