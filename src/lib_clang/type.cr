require "../type_kind"

lib LibClang
  enum CallingConv
    Default = 0
    C = 1
    X86StdCall = 2
    X86FastCall = 3
    X86ThisCall = 4
    X86Pascal = 5
    AAPCS = 6
    AAPCS_VFP = 7
    IntelOclBicc = 9
    X86_64Win64 = 10
    X86_64SysV = 11
    X86VectorCall = 12
    Swift = 13
    PreserveMost = 14
    PreserveAll = 15

    Invalid = 100
    Unexposed = 200
  end

  enum TemplateArgumentKind
    Null
    Type
    Declaration
    NullPtr
    Integral
    Template
    TemplateExpansion
    Expression
    Pack
    Invalid
  end

  enum TypeLayoutError
    Invalid = -1
    Incomplete = -2
    Dependent = -3
    NotConstantSize = -4
    InvalidFieldName = -5
  end

  enum RefQualifierKind
    None = 0
    LValue
    RValue
  end

  enum AccessSpecifier
    InvalidAccessSpecifier
    Public
    Protected
    Private
  end

  enum StorageClass
    Invalid
    None
    Extern
    Static
    PrivateExtern
    OpenCLWorkGroupLocal
    Auto
    Register
  end

  struct Type
    kind : Clang::TypeKind
    data : StaticArray(Void*, 2)
  end

  fun getCursorType = clang_getCursorType(Cursor) : Type
  fun getTypeSpelling = clang_getTypeSpelling(Type) : String
  fun getTypedefDeclUnderlyingType = clang_getTypedefDeclUnderlyingType(Cursor) : Type
  fun getEnumDeclIntegerType = clang_getEnumDeclIntegerType(Cursor) : Type
  fun getEnumConstantDeclValue = clang_getEnumConstantDeclValue(Cursor) : LongLong
  fun getEnumConstantDeclUnsignedValue = clang_getEnumConstantDeclUnsignedValue(Cursor) : ULongLong
  fun getFieldDeclBitWidth = clang_getFieldDeclBitWidth(Cursor) : Int
  fun cursor_getNumArguments = clang_Cursor_getNumArguments(Cursor) : Int
  fun cursor_getArgument = clang_Cursor_getArgument(Cursor, UInt) : Cursor
  fun cursor_getNumTemplateArguments = clang_Cursor_getNumTemplateArguments(Cursor) : Int
  fun cursor_getTemplateArgumentKind = clang_Cursor_getTemplateArgumentKind(Cursor, UInt) : TemplateArgumentKind
  fun cursor_getTemplateArgumentType = clang_Cursor_getTemplateArgumentType(Cursor, UInt) : Type
  fun cursor_getTemplateArgumentValue = clang_Cursor_getTemplateArgumentValue(Cursor, UInt) : LongLong
  fun cursor_getTemplateArgumentUnsignedValue = clang_Cursor_getTemplateArgumentUnsignedValue(Cursor, UInt) : ULongLong
  fun equalTypes = clang_equalTypes(Type, Type) : UInt
  fun getCanonicalType = clang_getCanonicalType(Type) : Type
  fun isConstQualifiedType = clang_isConstQualifiedType(Type) : UInt
  fun cursor_isMacroFunctionLike = clang_Cursor_isMacroFunctionLike(Cursor) : UInt
  fun cursor_isMacroBuiltin = clang_Cursor_isMacroBuiltin(Cursor) : UInt
  fun cursor_isFunctionInlined = clang_Cursor_isFunctionInlined(Cursor) : UInt
  fun isVolatileQualifiedType = clang_isVolatileQualifiedType(Type) : UInt
  fun isRestrictQualifiedType = clang_isRestrictQualifiedType(Type) : UInt
  fun getPointeeType = clang_getPointeeType(Type) : Type
  fun getTypeDeclaration = clang_getTypeDeclaration(Type) : Cursor
  fun getDeclObjCTypeEncoding = clang_getDeclObjCTypeEncoding(Cursor) : String
  fun type_getObjCEncoding = clang_Type_getObjCEncoding(Type) : String
  fun getTypeKindSpelling = clang_getTypeKindSpelling(Clang::TypeKind) : String
  fun getFunctionTypeCallingConv = clang_getFunctionTypeCallingConv(Type) : CallingConv
  fun getResultType = clang_getResultType(Type) : Type
  fun getNumArgTypes = clang_getNumArgTypes(Type) : Int
  fun getArgType = clang_getArgType(Type, UInt) : Type
  fun isFunctionTypeVariadic = clang_isFunctionTypeVariadic(Type) : UInt
  fun getCursorResultType = clang_getCursorResultType(Cursor) : Type
  fun isPODType = clang_isPODType(Type) : UInt
  fun getElementType = clang_getElementType(Type) : Type
  fun getNumElements = clang_getNumElements(Type) : LongLong
  fun getArrayElementType = clang_getArrayElementType(Type) : Type
  fun getArraySize = clang_getArraySize(Type) : LongLong
  fun type_getNamedType = clang_Type_getNamedType(Type) : Type
  fun type_getAlignOf = clang_Type_getAlignOf(Type) : LongLong
  fun type_getClassType = clang_Type_getClassType(Type) : Type
  fun type_getSizeOf = clang_Type_getSizeOf(Type) : LongLong
  fun type_getOffsetOf = clang_Type_getOffsetOf(Type, Char*) : LongLong
  fun cursor_getOffsetOfField = clang_Cursor_getOffsetOfField(Cursor) : LongLong
  fun cursor_isAnonymous = clang_Cursor_isAnonymous(Cursor) : UInt
  fun type_getNumTemplateArguments = clang_Type_getNumTemplateArguments(Type) : Int
  fun type_getTemplateArgumentAsType = clang_Type_getTemplateArgumentAsType(Type, UInt) : Type
  fun type_getCXXRefQualifier = clang_Type_getCXXRefQualifier(Type) : RefQualifierKind
  fun cursor_isBitField = clang_Cursor_isBitField(Cursor) : UInt
  fun isVirtualBase = clang_isVirtualBase(Cursor) : UInt
  fun getCXXAccessSpecifier = clang_getCXXAccessSpecifier(Cursor) : AccessSpecifier
  fun cursor_getStorageClass = clang_Cursor_getStorageClass(Cursor) : StorageClass
  fun getNumOverloadedDecls = clang_getNumOverloadedDecls(Cursor) : UInt
  fun getOverloadedDecl = clang_getOverloadedDecl(Cursor, UInt) : Cursor
  fun getIBOutletCollectionType = clang_getIBOutletCollectionType(Cursor) : Type
end
