module Clang
  class EvalResult
    alias Kind = LibClang::EvalResultKind

    def initialize(@result : LibClang::EvalResult)
    end

    def kind
      LibClang.evalResult_getKind(self)
    end

    def as_int
      LibClang.evalResult_getAsInt(self)
    end

    # def unsigned?
    #   LibClang.evalResult_isUnsignedInt(self) != 0
    # end

    # def as_unsigned
    #   LibClang.evalResult_getAsUnsigned(self)
    # end

    # def as_long_long
    #   LibClang.evalResult_getAsLongLong(self)
    # end

    def as_double
      LibClang.evalResult_getAsDouble(self)
    end

    def as_str
      Clang.string(LibClang.evalResult_getAsStr(self))
    end

    def finalize
      LibClang.evalResult_dispose(self)
    end

    def to_unsafe
      @result
    end
  end
end
