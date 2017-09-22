lib LibClang
  struct SourceLocation
    ptr_data : StaticArray(Void*, 2)
    int_data : UInt
  end

  struct SourceRange
    ptr_data : StaticArray(Void*, 2)
    begin_int_data : UInt
    end_int_data : UInt
  end

  struct SourceRangeList
    count : UInt
    ranges : SourceRange*
  end

  fun getNullLocation = clang_getNullLocation() : SourceLocation
  fun equalLocations = clang_equalLocations(SourceLocation, SourceLocation) : UInt
  fun getLocation = clang_getLocation(TranslationUnit, File) : SourceLocation
  fun getLocation_for_offset = clang_getLocationForOffset(TranslationUnit, File, UInt, UInt) : SourceLocation
  fun location_isInSystemHeader = clang_Location_isInSystemHeader(SourceLocation) : Int
  fun location_isFromMainFile = clang_Location_isFromMainFile(SourceLocation) : Int

  fun getNullRange = clang_getNullRange() : SourceRange
  fun getRange = clang_getRange(SourceLocation, SourceLocation) : SourceRange
  fun equalRanges = clang_equalRanges(SourceRange, SourceRange) : UInt
  fun range_isNull = clang_Range_isNull(SourceRange) : Int

  fun getExpansionLocation = clang_getExpansionLocation(SourceLocation, File*, UInt*, UInt*, UInt*);
  fun getPresumedLocation = clang_getPresumedLocation(SourceLocation, File*, UInt*, UInt*, UInt*);
  fun getInstantiationLocation = clang_getInstantiationLocation(SourceLocation, File*, UInt*, UInt*, UInt*);
  fun getSpellingLocation = clang_getSpellingLocation(SourceLocation, File*, UInt*, UInt*, UInt*);
  fun getFileLocation = clang_getFileLocation(SourceLocation, File*, UInt*, UInt*, UInt*);

  fun getRangeStart = clang_getRangeStart(SourceRange) : SourceLocation
  fun getRangeEnd = clang_getRangeEnd(SourceRange)
  fun getSkippedRanges = clang_getSkippedRanges(TranslationUnit, File) : SourceRangeList*
  fun disposeSourceRangeList = clang_disposeSourceRangeList(SourceRangeList*);
end
