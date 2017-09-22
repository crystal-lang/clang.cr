lib LibClang
  type CompletionString = Void*

  enum CompletionChunkKind
    Optional
    TypedText
    Text
    Placeholder
    Informative
    CurrentParameter
    LeftParen
    RightParen
    LeftBracket
    RightBracket
    LeftBrace
    RightBrace
    LeftAngle
    RightAngle
    Comma
    ResultType
    Colon
    SemiColon
    Equal
    HorizontalSpace
    VerticalSpace
  end

  @[Flags]
  enum CodeComplete_Flags : UInt
    IncludeMacros = 0x01
    IncludeCodePatterns = 0x02
    IncludeBriefComments = 0x04
  end

  enum CompletionContext : ULongLong
    Unexposed = 0
    AnyType = 1 << 0
    AnyValue = 1 << 1
    ObjCObjectValue = 1 << 2
    ObjCSelectorValue = 1 << 3
    XClassTypeValue = 1 << 4
    DotMemberAccess = 1 << 5
    ArrowMemberAccess = 1 << 6
    ObjCPropertyAccess = 1 << 7
    EnumTag = 1 << 8
    UnionTag = 1 << 9
    StructTag = 1 << 10
    ClassTag = 1 << 11
    Namespace = 1 << 12
    NestedNameSpecifier = 1 << 13
    ObjCInterface = 1 << 14
    ObjCProtocol = 1 << 15
    ObjCCategory = 1 << 16
    ObjCInstanceMessage = 1 << 17
    ObjCClassMessage = 1 << 18
    ObjCSelectorName = 1 << 19
    MacroName = 1 << 20
    NaturalLanguage = 1 << 21
    Unknown = ((1 << 22) - 1)
  end

  struct CompletionResult
    cursor_kind : CursorKind
    completion_string : CompletionString
  end

  struct CodeCompleteResults
    results : CompletionResult*;
    num_results : UInt
  end

  fun getCompletionChunkKind = clang_getCompletionChunkKind(CompletionString, UInt) : CompletionChunkKind
  fun getCompletionChunkText = clang_getCompletionChunkText(CompletionString, UInt) : String
  fun getCompletionChunkCompletionString = clang_getCompletionChunkCompletionString(CompletionString, UInt) : CompletionString
  fun getNumCompletionChunks = clang_getNumCompletionChunks(CompletionString) : UInt
  fun getCompletionPriority = clang_getCompletionPriority(CompletionString) : UInt
  fun getCompletionAvailability = clang_getCompletionAvailability(CompletionString) : AvailabilityKind
  fun getCompletionNumAnnotations = clang_getCompletionNumAnnotations(CompletionString) : UInt
  fun getCompletionAnnotation = clang_getCompletionAnnotation(CompletionString, UInt) : String
  fun getCompletionParent = clang_getCompletionParent(CompletionString, CursorKind*) : String
  fun getCompletionBriefComment = clang_getCompletionBriefComment(CompletionString) : String
  fun getCursorCompletionString = clang_getCursorCompletionString(Cursor) : CompletionString

  fun defaultCodeCompleteOptions = clang_defaultCodeCompleteOptions() : CodeComplete_Flags
  fun codeCompleteAt = clang_codeCompleteAt(TranslationUnit, Char*, UInt, UInt, UnsavedFile *, UInt, CodeComplete_Flags) : CodeCompleteResults*
  fun sortCodeCompletionResults = clang_sortCodeCompletionResults(CompletionResult*, UInt) : Void
  fun disposeCodeCompleteResults = clang_disposeCodeCompleteResults(CodeCompleteResults*) : Void
  fun codeCompleteGetNumDiagnostics = clang_codeCompleteGetNumDiagnostics(CodeCompleteResults*) : UInt
  fun codeCompleteGetDiagnostic = clang_codeCompleteGetDiagnostic(CodeCompleteResults*, UInt) : Diagnostic
  fun codeCompleteGetContexts = clang_codeCompleteGetContexts(CodeCompleteResults *) : CompletionContext
  fun codeCompleteGetContainerKind = clang_codeCompleteGetContainerKind(CodeCompleteResults*, UInt*) : CursorKind
  fun codeCompleteGetContainerUSR = clang_codeCompleteGetContainerUSR(CodeCompleteResults*) : String
  fun codeCompleteGetObjCSelector = clang_codeCompleteGetObjCSelector(CodeCompleteResults*) : String
end
