lib LibClang
  @[Flags]
  enum NameRefFlags : UInt
    WantQualifier = 0x1
    WantTemplateArgs = 0x2
    WantSinglePiece = 0x4
  end

  fun cxxConstructor_isConvertingConstructor = clang_CXXConstructor_isConvertingConstructor(Cursor) : UInt
  fun cxxConstructor_isCopyConstructor = clang_CXXConstructor_isCopyConstructor(Cursor) : UInt
  fun cxxConstructor_isDefaultConstructor = clang_CXXConstructor_isDefaultConstructor(Cursor) : UInt
  fun cxxConstructor_isMoveConstructor = clang_CXXConstructor_isMoveConstructor(Cursor) : UInt
  fun cxxField_isMutable = clang_CXXField_isMutable(Cursor) : UInt
  fun cxxMethod_isDefaulted = clang_CXXMethod_isDefaulted(Cursor) : UInt
  fun cxxMethod_isPureVirtual = clang_CXXMethod_isPureVirtual(Cursor) : UInt
  fun cxxMethod_isStatic = clang_CXXMethod_isStatic(Cursor) : UInt
  fun cxxMethod_isVirtual = clang_CXXMethod_isVirtual(Cursor) : UInt
  fun cxxMethod_isConst = clang_CXXMethod_isConst(Cursor) : UInt
  fun getTemplateCursorKind = clang_getTemplateCursorKind(Cursor) : CursorKind
  fun getSpecializedCursorTemplate = clang_getSpecializedCursorTemplate(Cursor) : Cursor
  fun getCursorReferenceNameRange = clang_getCursorReferenceNameRange(Cursor, NameRefFlags, UInt) : SourceRange
end
