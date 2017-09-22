lib LibClang
  struct String
    data : Void*
    private_flags : UInt
  end

  struct StringSet
    strings : String*
    count : UInt
  end

  fun getCString = clang_getCString(String) : Char*
  fun disposeString = clang_disposeString(String) : Void
  fun disposeStringSet = clang_disposeStringSet(StringSet*) : Void
end
