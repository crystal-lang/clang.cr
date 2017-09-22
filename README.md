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

## Samples

See the `samples` folder for some example usages:

- `samples/debug.cr` will print the AST of C or C++ headers as they are parsed;
- `samples/c2cr.cr` will automatically generate Crystal bindings for a C header.

For example:

```sh
$ crystal build samples/c2cr.cr
$ ./c2cr -I/usr/lib/llvm-5.0/include llvm-c/Core.h > Core.cr
```

## Reference

- [C interface to Clang](http://clang.llvm.org/doxygen/group__CINDEX.html)

## License

Distributed under the Apache 2.0 license.
