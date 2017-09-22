require "./lib_clang/error_code"
require "./lib_clang/string"
require "./lib_clang/build_system"

@[Link("clang", ldflags: "`llvm-config-3.9 --ldflags 2>/dev/null || llvm-config --ldflags 2>/dev/null`")]
lib LibClang
  alias Char = LibC::Char
  alias Double = LibC::Double
  alias Int = LibC::Int
  alias Long = LibC::Long
  alias LongLong = LibC::LongLong
  alias UInt = LibC::UInt
  alias ULong = LibC::ULong
  alias ULongLong = LibC::ULongLong

  enum AvailabilityKind
    Available
    Deprecated
    NotAvailable
    NotAccessible
  end

  @[Flags]
  enum GlobalOptions : UInt
    None = 0
    ThreadBackgroundPriorityForIndexing = 1
    ThreadBackgroundPriorityForEditing = 2
    ThreadBackgroundPriorityForAll = 3 # ThreadBackgroundPriorityForIndexing | ThreadBackgroundPriorityForEditing
  end

  type ClientData = Void*
  type Index = Void*

  struct Version
    major : Int
    minor : Int
    subminor : Int
  end

  fun createIndex = clang_createIndex(Int, Int) : Index
  fun disposeIndex = clang_disposeIndex(Index) : Void
  fun index_setGlobalOptions = clang_Index_setGlobalOptions(Index, GlobalOptions) : Void
  fun index_getGlobalOptions = clang_Index_getGlobalOptions(Index) : GlobalOptions
end

require "./lib_clang/file"
require "./lib_clang/locations"
require "./lib_clang/diagnostics"
require "./lib_clang/translation_unit"
require "./lib_clang/cursor"
require "./lib_clang/type"
require "./lib_clang/traversal"
require "./lib_clang/xref"
require "./lib_clang/mangle"
require "./lib_clang/module"
require "./lib_clang/ast"
require "./lib_clang/lex"
require "./lib_clang/debug"
require "./lib_clang/autocomplete"
require "./lib_clang/misc"
require "./lib_clang/remapping"
require "./lib_clang/high"
