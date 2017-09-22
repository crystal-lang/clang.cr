lib LibClang
  enum TokenKind
    Punctuation
    Keyword
    Identifier
    Literal
    Comment
  end

  struct Token
    int_data : StaticArray(UInt, 4)
    ptr_data : Void*
  end

  fun getTokenKind = clang_getTokenKind(Token) : TokenKind
  fun getTokenSpelling = clang_getTokenSpelling(TranslationUnit, Token) : String
  fun getTokenLocation = clang_getTokenLocation(TranslationUnit, Token) : SourceLocation
  fun getTokenExtent = clang_getTokenExtent(TranslationUnit, Token) : SourceRange
  fun tokenize = clang_tokenize(TranslationUnit, SourceRange, Token**, UInt*) : Void
  fun annotateTokens = clang_annotateTokens(TranslationUnit, Token*, UInt, Cursor*) : Void
  fun disposeTokens = clang_disposeTokens(TranslationUnit, Token*, UInt) : Void
end
