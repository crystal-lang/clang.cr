lib LibClang
  enum ObjCPropertyAttrKind : UInt
    Noattr    = 0x00
    Readonly  = 0x01
    Getter    = 0x02
    Assign    = 0x04
    Readwrite = 0x08
    Retain    = 0x10
    Copy      = 0x20
    Nonatomic = 0x40
    Setter    = 0x80
    Atomic    = 0x100
    Weak      = 0x200
    Strong    = 0x400
    Unsafe_unretained = 0x800
    Class = 0x1000
  end

  enum ObjCDeclQualifierKind : UInt
    None = 0x0
    In = 0x1
    Inout = 0x2
    Out = 0x4
    Bycopy = 0x8
    Byref = 0x10
    Oneway = 0x20
  end

  fun getCursorUSR = clang_getCursorUSR(Cursor) : String
  fun constructUSR_ObjCClass = clang_constructUSR_ObjCClass(Char*) : String
  fun constructUSR_ObjCCategory = clang_constructUSR_ObjCCategory(Char*, Char*) : String
  fun constructUSR_ObjCProtocol = clang_constructUSR_ObjCProtocol(Char*) : String
  fun constructUSR_ObjCIvar = clang_constructUSR_ObjCIvar(Char*, String) : String
  fun constructUSR_ObjCMethod = clang_constructUSR_ObjCMethod(Char*, UInt, String) : String
  fun constructUSR_ObjCProperty = clang_constructUSR_ObjCProperty(Char*, String) : String
  fun getCursorSpelling = clang_getCursorSpelling(Cursor) : String
  fun cursor_getSpellingNameRange = clang_Cursor_getSpellingNameRange(Cursor, UInt, UInt) : SourceRange
  fun getCursorDisplayName = clang_getCursorDisplayName(Cursor) : String
  fun getCursorReferenced = clang_getCursorReferenced(Cursor) : Cursor
  fun getCursorDefinition = clang_getCursorDefinition(Cursor) : Cursor
  fun isCursorDefinition = clang_isCursorDefinition(Cursor) : UInt
  fun getCanonicalCursor = clang_getCanonicalCursor(Cursor) : Cursor
  fun cursor_getObjCSelectorIndex = clang_Cursor_getObjCSelectorIndex(Cursor) : Int
  fun cursor_isDynamicCall = clang_Cursor_isDynamicCall(Cursor) : Int
  fun cursor_getReceiverType = clang_Cursor_getReceiverType(Cursor) : Type
  fun cursor_getObjCPropertyAttributes = clang_Cursor_getObjCPropertyAttributes(Cursor, UInt) : ObjCPropertyAttrKind
  fun cursor_getCommentRange = clang_Cursor_getCommentRange(Cursor) : SourceRange
  fun cursor_getRawCommentText = clang_Cursor_getRawCommentText(Cursor) : String
  fun cursor_getBriefCommentText = clang_Cursor_getBriefCommentText(Cursor) : String
  fun cursor_getObjCDeclQualifiers = clang_Cursor_getObjCDeclQualifiers(Cursor) : ObjCDeclQualifierKind
  fun cursor_isObjCOptional = clang_Cursor_isObjCOptional(Cursor) : UInt
  fun cursor_isVariadic = clang_Cursor_isVariadic(Cursor) : UInt
  fun cursor_getCommentRange = clang_Cursor_getCommentRange(Cursor) : SourceRange
  fun cursor_getRawCommentText = clang_Cursor_getRawCommentText(Cursor) : String
end
