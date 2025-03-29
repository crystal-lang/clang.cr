lib LibC
  # LLVM_CLANG_C_CXSOURCE_LOCATION_H = 
  struct CXSourceLocation
    ptr_data : StaticArray(Void*, 2)
    int_data : UInt
  end
  struct CXSourceRange
    ptr_data : StaticArray(Void*, 2)
    begin_int_data : UInt
    end_int_data : UInt
  end
  fun clang_getNullLocation() : CXSourceLocation
  fun clang_equalLocations(CXSourceLocation, CXSourceLocation) : UInt
  fun clang_Location_isInSystemHeader(CXSourceLocation) : Int
  fun clang_Location_isFromMainFile(CXSourceLocation) : Int
  fun clang_getNullRange() : CXSourceRange
  fun clang_getRange(CXSourceLocation, CXSourceLocation) : CXSourceRange
  fun clang_equalRanges(CXSourceRange, CXSourceRange) : UInt
  fun clang_Range_isNull(CXSourceRange) : Int
  fun clang_getExpansionLocation(CXSourceLocation, CXFile*, UInt*, UInt*, UInt*) : Void
  fun clang_getPresumedLocation(CXSourceLocation, CXString*, UInt*, UInt*) : Void
  fun clang_getInstantiationLocation(CXSourceLocation, CXFile*, UInt*, UInt*, UInt*) : Void
  fun clang_getSpellingLocation(CXSourceLocation, CXFile*, UInt*, UInt*, UInt*) : Void
  fun clang_getFileLocation(CXSourceLocation, CXFile*, UInt*, UInt*, UInt*) : Void
  fun clang_getRangeStart(CXSourceRange) : CXSourceLocation
  fun clang_getRangeEnd(CXSourceRange) : CXSourceLocation
  struct CXSourceRangeList
    count : UInt
    ranges : CXSourceRange*
  end
  fun clang_disposeSourceRangeList(CXSourceRangeList*) : Void
end
