.POSIX:

CRYSTAL = crystal
CRFLAGS = --release
LLVM_INCLUDE = /usr/lib/llvm-18/include

all: bin/c2cr

bin/c2cr: samples/c2cr.cr samples/c2cr/*.cr src/*.cr src/clang-c/*
	@mkdir -p bin
	$(CRYSTAL) build $(CRFLAGS) samples/c2cr.cr -o bin/c2cr

libclang: .PHONY
	@mkdir -p src/clang-c/
	bin/c2cr -I$(LLVM_INCLUDE) --remove-enum-prefix clang-c/BuildSystem.h > src/clang-c/BuildSystem.cr
	# bin/c2cr -I$(LLVM_INCLUDE) --remove-enum-prefix clang-c/CXCompilationDatabase.h > src/clang-c/CXCompilationDatabase.cr
	bin/c2cr -I$(LLVM_INCLUDE) --remove-enum-prefix clang-c/CXDiagnostic.h > src/clang-c/CXDiagnostic.cr
	bin/c2cr -I$(LLVM_INCLUDE) --remove-enum-prefix clang-c/CXErrorCode.h > src/clang-c/CXErrorCode.cr
	bin/c2cr -I$(LLVM_INCLUDE) --remove-enum-prefix clang-c/CXFile.h > src/clang-c/CXFile.cr
	bin/c2cr -I$(LLVM_INCLUDE) --remove-enum-prefix clang-c/CXSourceLocation.h > src/clang-c/CXSourceLocation.cr
	bin/c2cr -I$(LLVM_INCLUDE) --remove-enum-prefix clang-c/CXString.h > src/clang-c/CXString.cr
	bin/c2cr -I$(LLVM_INCLUDE) --remove-enum-prefix clang-c/Documentation.h > src/clang-c/Documentation.cr
	# bin/c2cr -I$(LLVM_INCLUDE) --remove-enum-prefix clang-c/ExternC.h > src/clang-c/ExternC.cr
	bin/c2cr -I$(LLVM_INCLUDE) --remove-enum-prefix clang-c/FatalErrorHandler.h > src/clang-c/FatalErrorHandler.cr
	bin/c2cr -I$(LLVM_INCLUDE) --remove-enum-prefix clang-c/Index.h > src/clang-c/Index.cr
	# bin/c2cr -I$(LLVM_INCLUDE) --remove-enum-prefix clang-c/Platform.h > src/clang-c/Platform.cr
	bin/c2cr -I$(LLVM_INCLUDE) --remove-enum-prefix clang-c/Rewrite.h > src/clang-c/Rewrite.cr

.PHONY:
