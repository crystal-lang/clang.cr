lib LibClang
  enum DiagnosticSeverity
    Ignored = 0
    Note    = 1
    Warning = 2
    Error   = 3
    Fatal   = 4
  end

  type Diagnostic = Void*
  type DiagnosticSet = Void*

  fun getNumDiagnosticsInSet = clang_getNumDiagnosticsInSet(DiagnosticSet) : UInt
  fun getDiagnosticInSet = clang_getDiagnosticInSet(DiagnosticSet, UInt) : Diagnostic

  enum LoadDiag_Error
    None = 0
    Unknown = 1
    CannotLoad = 2
    InvalidFile = 3
  end

  fun loadDiagnostics = clang_loadDiagnostics(Char*, LoadDiag_Error*, String*) : DiagnosticSet
  fun disposeDiagnosticSet = clang_disposeDiagnosticSet(DiagnosticSet) : Void
  fun getChildDiagnostics = clang_getChildDiagnostics(Diagnostic) : DiagnosticSet
  fun getNumDiagnostics = clang_getNumDiagnostics(TranslationUnit) : UInt
  fun getDiagnostic = clang_getDiagnostic(TranslationUnit, UInt) : Diagnostic
  fun getDiagnosticSetFromTU = clang_getDiagnosticSetFromTU(TranslationUnit) : DiagnosticSet
  fun disposeDiagnostic = clang_disposeDiagnostic(Diagnostic) : Void

  enum DiagnosticDisplayOptions : UInt
    DisplaySourceLocation = 0x01
    DisplayColumn = 0x02
    DisplaySourceRanges = 0x04
    DisplayOption = 0x08
    DisplayCategoryId = 0x10
    DisplayCategoryName = 0x20
  end

  fun formatDiagnostic = clang_formatDiagnostic(Diagnostic, UInt) : String
  fun defaultDiagnosticDisplayOptions = clang_defaultDiagnosticDisplayOptions() : UInt
  fun getDiagnosticSeverity = clang_getDiagnosticSeverity(Diagnostic) : DiagnosticSeverity
  fun getDiagnosticLocation = clang_getDiagnosticLocation(Diagnostic) : SourceLocation
  fun getDiagnosticSpelling = clang_getDiagnosticSpelling(Diagnostic) : String
  fun getDiagnosticOption = clang_getDiagnosticOption(Diagnostic, String*) : String

  fun getDiagnosticCategory = clang_getDiagnosticCategory(Diagnostic) : UInt
 #fun getDiagnosticCategoryName = clang_getDiagnosticCategoryName(UInt) : String
  fun getDiagnosticCategoryText = clang_getDiagnosticCategoryText(Diagnostic) : String
  fun getDiagnosticNumRanges = clang_getDiagnosticNumRanges(Diagnostic) : UInt
  fun getDiagnosticRange = clang_getDiagnosticRange(Diagnostic, UInt) :  SourceRange
  fun getDiagnosticNumFixIts = clang_getDiagnosticNumFixIts(Diagnostic) : UInt
  fun getDiagnosticFixIt = clang_getDiagnosticFixIt(Diagnostic, UInt, SourceRange*) :  String
end
