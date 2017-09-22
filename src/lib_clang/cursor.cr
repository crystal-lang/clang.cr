require "../cursor_kind"

lib LibClang
  alias CursorKind = Clang::CursorKind

  enum LinkageKind
    Invalid
    NoLinkage
    Internal
    UniqueExternal
    External
  end

  enum VisibilityKind
    Invalid
    Hidden
    Protected
    Default
  end

  struct PlatformAvailability
    platform : String
    introduced : Version
    deprecated : Version
    obsoleted : Version
    unavailable : Int
    message : String
  end

  enum LanguageKind
    Invalid = 0
    C
    ObjC
    CPlusPlus
  end

  struct Cursor
    kind : CursorKind
    xdata : Int
    data : StaticArray(Void*, 3)
  end

  type CursorSet = Void*

  fun getNullCursor = clang_getNullCursor() : Cursor
  fun getTranslationUnitCursor = clang_getTranslationUnitCursor(TranslationUnit) : Cursor
  fun equalCursors = clang_equalCursors(Cursor, Cursor) : UInt
  fun cursor_isNull = clang_Cursor_isNull(Cursor) : Int
  fun hashCursor = clang_hashCursor(Cursor) : UInt
  fun getCursorKind = clang_getCursorKind(Cursor) : CursorKind
  fun isDeclaration = clang_isDeclaration(CursorKind) : UInt
  fun isReference = clang_isReference(CursorKind) : UInt
  fun isExpression = clang_isExpression(CursorKind) : UInt
  fun isStatement = clang_isStatement(CursorKind) : UInt
  fun isAttribute = clang_isAttribute(CursorKind) : UInt
  fun cursor_hasAttrs = clang_Cursor_hasAttrs(Cursor) : UInt
  fun isInvalid = clang_isInvalid(CursorKind) : UInt
  fun isTranslationUnit = clang_isTranslationUnit(CursorKind) : UInt
  fun isPreprocessing = clang_isPreprocessing(CursorKind) : UInt
  fun isUnexposed = clang_isUnexposed(CursorKind) : UInt
  fun getCursorLinkage = clang_getCursorLinkage(Cursor) : LinkageKind
  fun getCursorVisibility = clang_getCursorVisibility(Cursor) : VisibilityKind
  fun getCursorAvailability = clang_getCursorAvailability(Cursor) : AvailabilityKind
  fun getCursorPlatformAvailability = clang_getCursorPlatformAvailability(Cursor, Int*, String*, Int*, String*, PlatformAvailability*, Int) : Int
  fun disposePlatformAvailability = clang_disposePlatformAvailability(PlatformAvailability*) : Void
  fun getCursorLanguage = clang_getCursorLanguage(Cursor) : LanguageKind
  fun cursor_getTranslationUnit = clang_Cursor_getTranslationUnit(Cursor) : TranslationUnit
  fun createCursorSet = clang_createCursorSet() : CursorSet
  fun disposeCursorSet = clang_disposeCursorSet(CursorSet) : Void
  fun cursorSet_contains = clang_CursorSet_contains(CursorSet, Cursor) : UInt
  fun cursorSet_insert = clang_CursorSet_insert(CursorSet, Cursor) : UInt
  fun getCursorSemanticParent = clang_getCursorSemanticParent(Cursor) : Cursor
  fun getCursorLexicalParent = clang_getCursorLexicalParent(Cursor) : Cursor
  fun getOverriddenCursors  = clang_getOverriddenCursors(Cursor, Cursor**, UInt*) : Void
  fun disposeOverriddenCursors = clang_disposeOverriddenCursors(Cursor*) : Void
  fun getIncludedFile = clang_getIncludedFile(Cursor) : File
  fun getCursor = clang_getCursor(TranslationUnit, SourceLocation) : Cursor
  fun getCursorLocation = clang_getCursorLocation(Cursor) : SourceLocation
  fun getCursorExtent = clang_getCursorExtent(Cursor) : SourceRange
end
