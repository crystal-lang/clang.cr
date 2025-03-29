enum LibC::CXUnaryOperatorKind
  def spelling
    Clang.string(LibC.clang_getUnaryOperatorKindSpelling(self))
  end
end
