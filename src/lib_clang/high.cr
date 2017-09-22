lib LibClang
  enum VisitorResult
    Break
    Continue
  end

  enum Result
    Result_Success = 0
    Result_Invalid = 1
    Result_VisitBreak = 2
  end

  enum IdxEntityRefKind
    Direct = 1,
    Implicit = 2
  end

  enum IdxEntityKind
    Unexposed     = 0
    Typedef       = 1
    Function      = 2
    Variable      = 3
    Field         = 4
    EnumConstant  = 5

    ObjCClass     = 6
    ObjCProtocol  = 7
    ObjCCategory  = 8

    ObjCInstanceMethod = 9
    ObjCClassMethod    = 10
    ObjCProperty  = 11
    ObjCIvar      = 12

    Enum          = 13
    Struct        = 14
    Union         = 15

    CXXClass              = 16
    CXXNamespace          = 17
    CXXNamespaceAlias     = 18
    CXXStaticVariable     = 19
    CXXStaticMethod       = 20
    CXXInstanceMethod     = 21
    CXXConstructor        = 22
    CXXDestructor         = 23
    CXXConversionFunction = 24
    CXXTypeAlias          = 25
    CXXInterface          = 26
  end

  enum IdxEntityLanguage
    None = 0
    C    = 1
    ObjC = 2
    CXX  = 3
  end

  enum IdxEntityCXXTemplateKind
    NonTemplate   = 0
    Template      = 1
    TemplatePartialSpecialization = 2
    TemplateSpecialization = 3
  end

  enum IdxAttrKind
    Unexposed     = 0
    IBAction      = 1
    IBOutlet      = 2
    IBOutletCollection = 3
  end

  enum IdxObjCContainerKind
    ForwardRef = 0
    Interface = 1
    Implementation = 2
  end

  @[Flags]
  enum IdxDeclInfoFlags : UInt
    IdxDeclFlag_Skipped = 0x1
  end

  enum IndexOptFlags : UInt
    None = 0x0
    SuppressRedundantRefs = 0x1
    IndexFunctionLocalSymbols = 0x2
    IndexImplicitTemplateInstantiations = 0x4
    SuppressWarnings = 0x8
    SkipParsedBodiesInSession = 0x10
  end

  fun findReferencesInFile = clang_findReferencesInFile(Cursor, File, CursorAndRangeVisitor) : Result
  fun findIncludesInFile = clang_findIncludesInFile(TranslationUnit, File, CursorAndRangeVisitor) : Result

  # alias CursorAndRangeVisitorBlock = (Cursor, SourceRange) -> VisitorResult
  # fun findReferencesInFileWithBlock = clang_findReferencesInFileWithBlock(Cursor, File, CursorAndRangeVisitorBlock) : Result
  # fun findIncludesInFileWithBlock = clang_findIncludesInFileWithBlock(TranslationUnit, File, CursorAndRangeVisitorBlock) : Result

  type IdxClientFile = Void*
  type IdxClientEntity = Void*
  type IdxClientContainer = Void*
  type IdxClientASTFile = Void*

  struct CursorAndRangeVisitor
    context : Void*
    visit : (Void*, Cursor, SourceRange) -> VisitorResult
  end

  struct IdxLoc
    ptr_data : StaticArray(Void*, 2)
    int_data : UInt
  end

  struct IdxIncludedFileInfo
    hashLoc : IdxLoc
    filename : Char*
    file : File
    isImport : Int
    isAngled : Int
    isModuleImport : Int
  end

  struct IdxImportedASTFileInfo
    file : File
    mod : Module
    loc : IdxLoc
    isImplicit : Int
  end

  struct IdxAttrInfo
    kind : IdxAttrKind
    cursor : Cursor
    loc : IdxLoc
  end

  struct IdxEntityInfo
    kind : IdxEntityKind
    templateKind : IdxEntityCXXTemplateKind
    lang : IdxEntityLanguage
    name : Char*
    usr : Char*
    cursor : Cursor
    attributes : IdxAttrInfo**
    numAttributes : UInt
  end

  struct IdxContainerInfo
     cursor : Cursor
  end

  struct IdxIBOutletCollectionAttrInfo
    attrInfo : IdxAttrInfo*
    objcClass : IdxEntityInfo*
    classCursor : Cursor
    classLoc : IdxLoc
  end

  struct IdxDeclInfo
    entityInfo : IdxEntityInfo*
    cursor : Cursor
    loc : IdxLoc
    semanticContainer : IdxContainerInfo*
    lexicalContainer : IdxContainerInfo*
    isRedeclaration : Int
    isDefinition : Int
    isContainer : Int
    declAsContainer : IdxContainerInfo*
    isImplicit : Int
    attributes : IdxAttrInfo**
    numAttributes : UInt
    flags : IdxDeclInfoFlags
  end

  struct IdxObjCContainerDeclInfo
    declInfo : IdxDeclInfo*
    kind : IdxObjCContainerKind
  end

  struct IdxBaseClassInfo
    base : IdxEntityInfo*
    cursor : Cursor
    loc : IdxLoc
  end

  struct IdxObjCProtocolRefInfo
    protocol : IdxEntityInfo *
    cursor : Cursor
    loc : IdxLoc
  end

  struct IdxObjCProtocolRefListInfo
    protocols : IdxObjCProtocolRefInfo**
    numProtocols : UInt
  end

  struct IdxObjCInterfaceDeclInfo
    containerInfo : IdxObjCContainerDeclInfo*
    superInfo : IdxBaseClassInfo*
    protocols : IdxObjCProtocolRefListInfo*
  end

  struct IdxObjCCategoryDeclInfo
    containerInfo : IdxObjCContainerDeclInfo*
    objcClass : IdxEntityInfo*
    classCursor : Cursor
    classLoc : IdxLoc
    protocols : IdxObjCProtocolRefListInfo*
  end

  struct IdxObjCPropertyDeclInfo
    declInfo : IdxDeclInfo*
    getter : IdxEntityInfo*
    setter : IdxEntityInfo*
  end

  struct IdxCXXClassDeclInfo
    declInfo : IdxDeclInfo*
    bases : IdxBaseClassInfo**
    numBases : UInt
  end

  struct IdxEntityRefInfo
    kind : IdxEntityRefKind
    cursor : Cursor
    loc : IdxLoc
    referencedEntity : IdxEntityInfo*
    parentEntity : IdxEntityInfo*
    container : IdxContainerInfo*
  end

  struct IndexerCallbacks
    abortQuery : (ClientData, Void*) -> Int
    diagnostic : (ClientData, DiagnosticSet, Void*) ->
    enteredMainFile : (ClientData, File, Void*) -> IdxClientFile
    ppIncludedFile : (ClientData, IdxIncludedFileInfo *) -> IdxClientFile
    importedASTFile : (ClientData, IdxImportedASTFileInfo *) -> IdxClientASTFile
    startedTranslationUnit : (ClientData, Void*) -> IdxClientContainer
    indexDeclaration : (ClientData, IdxDeclInfo*) ->
    indexEntityReference : (ClientData, IdxEntityRefInfo *) ->
  end

  type IndexAction = Void*

  fun index_isEntityObjCContainerKind = clang_index_isEntityObjCContainerKind(IdxEntityKind) : Int
  fun index_getObjCContainerDeclInfo = clang_index_getObjCContainerDeclInfo(IdxDeclInfo *) : IdxObjCContainerDeclInfo*
  fun index_getObjCInterfaceDeclInfo = clang_index_getObjCInterfaceDeclInfo(IdxDeclInfo *) : IdxObjCInterfaceDeclInfo*
  fun index_getObjCCategoryDeclInfo = clang_index_getObjCCategoryDeclInfo(IdxDeclInfo *) : IdxObjCCategoryDeclInfo*
  fun index_getObjCProtocolRefListInfo = clang_index_getObjCProtocolRefListInfo(IdxDeclInfo *) : IdxObjCProtocolRefListInfo*
  fun index_getObjCPropertyDeclInfo = clang_index_getObjCPropertyDeclInfo(IdxDeclInfo *) : IdxObjCPropertyDeclInfo*
  fun index_getIBOutletCollectionAttrInfo = clang_index_getIBOutletCollectionAttrInfo(IdxAttrInfo *) : IdxIBOutletCollectionAttrInfo*
  fun index_getCXXClassDeclInfo = clang_index_getCXXClassDeclInfo(IdxDeclInfo *) : IdxCXXClassDeclInfo*
  fun index_getClientContainer = clang_index_getClientContainer(IdxContainerInfo *) : IdxClientContainer
  fun index_setClientContainer = clang_index_setClientContainer(IdxContainerInfo *,IdxClientContainer) : Void
  fun index_getClientEntity = clang_index_getClientEntity(IdxEntityInfo *) : IdxClientEntity
  fun index_setClientEntity = clang_index_setClientEntity(IdxEntityInfo *, IdxClientEntity) : Void
  fun indexAction_create = clang_IndexAction_create(Index) : IndexAction
  fun indexAction_dispose = clang_IndexAction_dispose(IndexAction) : Void

  fun indexSourceFile = clang_indexSourceFile(IndexAction, ClientData, IndexerCallbacks*, UInt, IndexOptFlags, Char*, Char**, Int, UnsavedFile*, UInt, TranslationUnit*, TranslationUnit_Flags) : Int
  fun indexSourceFileFullArgv = clang_indexSourceFileFullArgv(IndexAction, ClientData, IndexerCallbacks*, UInt, IndexOptFlags, Char*, Char**, Int, UnsavedFile*, UInt, TranslationUnit*, TranslationUnit_Flags) : Int
  fun indexTranslationUnit = clang_indexTranslationUnit(IndexAction, ClientData, IndexerCallbacks*, UInt, UInt, TranslationUnit) : Int
  fun indexLoc_getFileLocation = clang_indexLoc_getFileLocation(IdxLoc, IdxClientFile*, File*, UInt*, UInt*, UInt*) : Void
  fun indexLoc_getSourceLocation = clang_indexLoc_getSourceLocation(IdxLoc) : SourceLocation

  alias FieldVisitor = (Cursor, ClientData) -> VisitorResult
  fun type_visitFields = clang_Type_visitFields(Type, FieldVisitor, ClientData) : UInt
end
