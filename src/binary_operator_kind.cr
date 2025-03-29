enum LibC::CXBinaryOperatorKind
  def spelling
    Clang.string(LibC.clang_getBinaryOperatorKindSpelling(self))
  end
end
