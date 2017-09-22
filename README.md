# libclang bindings for Crystal

```crystal
require "clang"

index = Clang::Index.new

files = [
  #Clang::UnsavedFile.new("input.c", "#include <pcre.h>\n"),
  Clang::UnsavedFile.new("input.c", "#include <clang/Basic/ABI.h>\n"),
]
tu = Clang::TranslationUnit.from_source(index, files, [
  "-I/usr/include",
  "-I/usr/lib/llvm-5.0/include",
])

tu.cursor.visit_children do |cursor|
  p cursor

  Clang::ChildVisitResult::Continue
end
```

## Reference

- [C interface to Clang](http://clang.llvm.org/doxygen/group__CINDEX.html)

## License

Distributed under the Apache 2.0 license.
