module Clang
  class PlatformAvailability
    def initialize(@platform)
    end

    def finalize
      LibClang.disposePlatformAvailability(self)
    end

    def platform
      Clang.string(@platform.platform)
    end

    def introduced
      @platform.introduced
    end

    def deprecated
      @platform.deprecated
    end

    def obsoleted
      @platform.obsoleted
    end

    def unavailable
      @platform.unavailable == 1
    end

    def message
      Clang.string(@platform.message)
    end

    def to_unsafe
      @platform
    end
  end
end
