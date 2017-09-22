lib LibClang
  type Remapping = Void*

  fun getRemappings = clang_getRemappings(Char*) : Remapping
  fun getRemappingsFromFileList = clang_getRemappingsFromFileList(Char**, UInt) : Remapping
  fun remap_getNumFiles = clang_remap_getNumFiles(Remapping) : UInt
  fun remap_getFilenames = clang_remap_getFilenames(Remapping, UInt, String*, String*) : Void
  fun remap_dispose = clang_remap_dispose(Remapping) : Void
end
