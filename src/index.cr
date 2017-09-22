module Clang
  class Index
    alias GlobalOptions = LibClang::GlobalOptions

    # Creates a new Index.
    #
    # - *exclude_declarations_from_pch*: allow enumeration of "local"
    #   declarations (when loading any new translation units). A "local"
    #   declaration is one that belongs in the translation unit itself and not
    #   in a precompiled header that was used by the translation unit. If zero,
    #   all declarations will be enumerated.
    def initialize(exclude_declarations_from_pch = false, display_diagnostics = true)
      @index = LibClang.createIndex(exclude_declarations_from_pch ? 1 : 0, display_diagnostics ? 1 : 0)
    end

    def finalize
      LibClang.disposeIndex(self)
    end

    def global_options
      LibClang.index_getGlobalOptions(self)
    end

    def global_options=(value : GlobalOptions)
      LibClang.index_setGlobalOptions(self, value)
      value
    end

    def to_unsafe
      @index
    end
  end
end
