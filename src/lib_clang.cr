require "./lib_clang/error_code"
require "./lib_clang/string"
require "./lib_clang/build_system"

{% begin %}
lib LibClang
  LLVM_CONFIG = {{
                  `[ -n "$LLVM_CONFIG" ] && command -v "$LLVM_CONFIG" || \
                   command -v llvm-config-5.0 || command -v llvm-config50 || \
                   command -v llvm-config-4.0 || command -v llvm-config40 || \
                   command -v llvm-config-3.9 || command -v llvm-config39 || \
                   command -v llvm-config
                  `.chomp.stringify
                }}
end
{% end %}

{% begin %}
  {% if flag?(:static) %}
    @[Link("clang", ldflags: "`{{LibClang::LLVM_CONFIG.id}} --ldflags --link-static 2> /dev/null`")]
  {% else %}
    @[Link("clang", ldflags: "`{{LibClang::LLVM_CONFIG.id}} --ldflags 2> /dev/null`")]
  {% end %}
{% end %}
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
