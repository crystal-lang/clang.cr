lib LibClang
  type Module = Void*

  fun cursor_getModule = clang_Cursor_getModule(Cursor) : Module
  fun getModuleForFile = clang_getModuleForFile(TranslationUnit, File) : Module
  fun module_getASTFile = clang_Module_getASTFile(Module) : File
  fun module_getParent = clang_Module_getParent(Module) : Module
  fun module_getName = clang_Module_getName(Module) : String
  fun module_getFullName = clang_Module_getFullName(Module) : String
  fun module_getTopLevelHeader = clang_Module_getTopLevelHeader(TranslationUnit, Module, UInt) : File
end
