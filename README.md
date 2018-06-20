# libclang bindings for Crystal

Usage:

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

## Applications using clang.cr

[autobind](https://github.com/j8r/crystal-autobind) (previously `c2cr` in this repo) - Automatic C bindings generator for Crystal 

## Reference

- [C interface to Clang](http://clang.llvm.org/doxygen/group__CINDEX.html)

## License

Distributed under the Apache 2.0 license.
