lib LibClang
  fun getCursorKindSpelling = clang_getCursorKindSpelling(CursorKind) : String
  fun getDefinitionSpellingAndExtent = clang_getDefinitionSpellingAndExtent(Cursor, Char**, Char**, UInt*, UInt*, UInt*, UInt*);
  fun enableStackTraces = clang_enableStackTraces()
  fun executeOnThread = clang_executeOnThread((Void*) ->, Void*, UInt);
end
