lib LibClang
  enum EvalResultKind
    Int = 1
    Float = 2
    ObjCStrLiteral = 3
    StrLiteral = 4
    CFStr = 5
    Other = 6
    UnExposed = 0
  end

  type EvalResult = Void*

  fun getClangVersion = clang_getClangVersion() : String
  fun toggleCrashRecovery = clang_toggleCrashRecovery(UInt)

  alias InclusionVisitor = (File, SourceLocation*, UInt, ClientData) ->
  fun getInclusions = clang_getInclusions(TranslationUnit, InclusionVisitor, ClientData)

  fun cursor_Evaluate = clang_Cursor_Evaluate(Cursor) : EvalResult
  fun evalResult_getKind = clang_EvalResult_getKind(EvalResult) : EvalResultKind
  fun evalResult_getAsInt = clang_EvalResult_getAsInt(EvalResult) : Int
  fun evalResult_getAsDouble = clang_EvalResult_getAsDouble(EvalResult) : Double
  fun evalResult_getAsStr = clang_EvalResult_getAsStr(EvalResult) : Char*
  fun evalResult_dispose = clang_EvalResult_dispose(EvalResult) : Void

  # fun evalResult_isUnsignedInt = clang_EvalResult_isUnsignedInt(EvalResult) : UInt
  # fun evalResult_getAsUnsigned = clang_EvalResult_getAsUnsigned(EvalResult) : UInt
  # fun evalResult_getAsLongLong = clang_EvalResult_getAsLongLong(EvalResult) : LongLong
end
