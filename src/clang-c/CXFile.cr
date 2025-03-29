lib LibC
  # LLVM_CLANG_C_CXFILE_H = 
  alias CXFile = Void*
  fun clang_getFileName(CXFile) : CXString
  fun clang_getFileTime(CXFile) : Long
  struct CXFileUniqueID
    data : StaticArray(ULongLong, 3)
  end
  fun clang_getFileUniqueID(CXFile, CXFileUniqueID*) : Int
  fun clang_File_isEqual(CXFile, CXFile) : Int
  fun clang_File_tryGetRealPathName(CXFile) : CXString
end
