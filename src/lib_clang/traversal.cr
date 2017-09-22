lib LibClang
  enum ChildVisitResult
    Break
    Continue
    Recurse
  end

  alias CursorVisitor = (Cursor, Cursor, Void*) -> ChildVisitResult
  fun visitChildren = clang_visitChildren(Cursor, CursorVisitor, Void*) : UInt

  # alias CursorVisitorBlock = (Cursor cursor, Cursor parent) -> ChildVisitResult
  # fun visitChildrenWithBlock = clang_visitChildrenWithBlock(Cursor, CursorVisitorBlock) : UInt
end
