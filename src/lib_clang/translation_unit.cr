lib LibClang
  @[Flags]
  enum TranslationUnit_Flags : UInt
    None = 0x0
    DetailedPreprocessingRecord = 0x01
    Incomplete = 0x02
    PrecompiledPreamble = 0x04
    CacheCompletionResults = 0x08
    ForSerialization = 0x10
    CXXChainedPCH = 0x20
    SkipFunctionBodies = 0x40
    IncludeBriefCommentsInCodeCompletion = 0x80
    CreatePreambleOnFirstParse = 0x100
    KeepGoing = 0x200
  end

  @[Flags]
  enum SaveTranslationUnit_Flags : UInt
    None = 0x0
  end

  enum SaveError
    None = 0
    Unknown = 1
    TranslationErrors = 2
    InvalidTU = 3
  end

  @[Flags]
  enum Reparse_Flags : UInt
    None = 0x0
  end

  enum TUResourceUsageKind
    AST = 1
    Identifiers = 2
    Selectors = 3
    GlobalCompletionResults = 4
    SourceManagerContentCache = 5
    AST_SideTables = 6
    SourceManager_Membuffer_Malloc = 7
    SourceManager_Membuffer_MMap = 8
    ExternalASTSource_Membuffer_Malloc = 9
    ExternalASTSource_Membuffer_MMap = 10
    Preprocessor = 11
    PreprocessingRecord = 12
    SourceManager_DataStructures = 13
    Preprocessor_HeaderSearch = 14
    MEMORY_IN_BYTES_BEGIN = AST
    MEMORY_IN_BYTES_END = Preprocessor_HeaderSearch
    First = AST
    Last = Preprocessor_HeaderSearch
  end

  struct TUResourceUsageEntry
    kind : TUResourceUsageKind
    amount : ULong
  end

  struct TUResourceUsage
    data : Void*
    numEntries : UInt
    entries : TUResourceUsageEntry*
  end

  type TranslationUnit = Void*

  fun createTranslationUnitFromSourceFile = clang_createTranslationUnitFromSourceFile(Index, Char*, Int, Char**, UInt, UnsavedFile*) : TranslationUnit
  fun createTranslationUnit = clang_createTranslationUnit(Index, Char*) : TranslationUnit
  fun createTranslationUnit2 = clang_createTranslationUnit2(Index, Char*, TranslationUnit*) : ErrorCode

  fun defaultEditingTranslationUnitOptions = clang_defaultEditingTranslationUnitOptions() : TranslationUnit_Flags
  fun parseTranslationUnit = clang_parseTranslationUnit(Index, Char*, Char**, Int, UnsavedFile*, UInt, TranslationUnit_Flags) : TranslationUnit
  fun parseTranslationUnit2 = clang_parseTranslationUnit2(Index, Char*, Char**, Int, UnsavedFile*, UInt, TranslationUnit_Flags, TranslationUnit*) : ErrorCode

  fun default_save_options = clang_defaultSaveOptions(TranslationUnit) : UInt
  fun saveTranslationUnit = clang_saveTranslationUnit(TranslationUnit, Char*, SaveTranslationUnit_Flags) : Int
  fun disposeTranslationUnit = clang_disposeTranslationUnit(TranslationUnit) : Void
  fun defaultReparseOptions = clang_defaultReparseOptions(TranslationUnit) : UInt
  fun reparseTranslationUnit = clang_reparseTranslationUnit(TranslationUnit, UInt, UnsavedFile*, UInt) : Int

  fun getTUResourceUsageName = clang_getTUResourceUsageName(TUResourceUsageKind) : Char*
  fun getTUResourceUsage = clang_getTUResourceUsage(TranslationUnit) : TUResourceUsage
  fun disposeTUResourceUsage = clang_disposeTUResourceUsage(TUResourceUsage) : Void
end
