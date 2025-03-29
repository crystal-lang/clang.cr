lib LibC
  # LLVM_CLANG_C_REWRITE_H = 
  alias CXRewriter = Void*
  fun clang_CXRewriter_create(CXTranslationUnit) : CXRewriter
  fun clang_CXRewriter_insertTextBefore(CXRewriter, CXSourceLocation, Char*) : Void
  fun clang_CXRewriter_replaceText(CXRewriter, CXSourceRange, Char*) : Void
  fun clang_CXRewriter_removeText(CXRewriter, CXSourceRange) : Void
  fun clang_CXRewriter_overwriteChangedFiles(CXRewriter) : Int
  fun clang_CXRewriter_writeMainFileToStdOut(CXRewriter) : Void
  fun clang_CXRewriter_dispose(CXRewriter) : Void
end
