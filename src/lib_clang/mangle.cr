lib LibClang
  fun cursor_getMangling = clang_Cursor_getMangling(Cursor) : String
  fun cursor_getCXXManglings = clang_Cursor_getCXXManglings(Cursor) : StringSet*
end
