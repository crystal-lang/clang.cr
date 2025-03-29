lib LibC
  # LLVM_CLANG_C_CXDIAGNOSTIC_H = 
  enum CXDiagnosticSeverity : UInt
    Ignored = 0
    Note = 1
    Warning = 2
    Error = 3
    Fatal = 4
  end
  alias CXDiagnostic = Void*
  alias CXDiagnosticSet = Void*
  fun clang_getNumDiagnosticsInSet(CXDiagnosticSet) : UInt
  fun clang_getDiagnosticInSet(CXDiagnosticSet, UInt) : CXDiagnostic
  enum CXLoadDiag_Error : UInt
    None = 0
    Unknown = 1
    CannotLoad = 2
    InvalidFile = 3
  end
  fun clang_loadDiagnostics(Char*, CXLoadDiag_Error*, CXString*) : CXDiagnosticSet
  fun clang_disposeDiagnosticSet(CXDiagnosticSet) : Void
  fun clang_getChildDiagnostics(CXDiagnostic) : CXDiagnosticSet
  fun clang_disposeDiagnostic(CXDiagnostic) : Void
  enum CXDiagnosticDisplayOptions : UInt
    SourceLocation = 1
    Column = 2
    SourceRanges = 4
    Option = 8
    CategoryId = 16
    CategoryName = 32
  end
  fun clang_formatDiagnostic(CXDiagnostic, UInt) : CXString
  fun clang_defaultDiagnosticDisplayOptions() : UInt
  fun clang_getDiagnosticSeverity(CXDiagnostic) : CXDiagnosticSeverity
  fun clang_getDiagnosticLocation(CXDiagnostic) : CXSourceLocation
  fun clang_getDiagnosticSpelling(CXDiagnostic) : CXString
  fun clang_getDiagnosticOption(CXDiagnostic, CXString*) : CXString
  fun clang_getDiagnosticCategory(CXDiagnostic) : UInt
  fun clang_getDiagnosticCategoryName(UInt) : CXString
  fun clang_getDiagnosticCategoryText(CXDiagnostic) : CXString
  fun clang_getDiagnosticNumRanges(CXDiagnostic) : UInt
  fun clang_getDiagnosticRange(CXDiagnostic, UInt) : CXSourceRange
  fun clang_getDiagnosticNumFixIts(CXDiagnostic) : UInt
  fun clang_getDiagnosticFixIt(CXDiagnostic, UInt, CXSourceRange*) : CXString
end
