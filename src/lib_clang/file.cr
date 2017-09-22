lib LibClang
  type File = Void*

  struct FileUniqueID
    data : StaticArray(ULongLong, 3)
  end

  struct UnsavedFile
    filename : Char*
    contents : Char*
    length : ULong
  end

  fun getFileName = clang_getFileName(File) : String
  fun getFileTime = clang_getFileTime(File) : LibC::TimeT
  fun getFileUniqueID = clang_getFileUniqueID(File, FileUniqueID*) : Int
  fun isFileMultipleIncludeGuarded = clang_isFileMultiple_IncludeGuarded(TranslationUnit, File) : UInt
  fun getFile = clang_getFile(TranslationUnit, Char*) : File
  fun file_isEqual = clang_File_isEqual(File, File) : Int
end
