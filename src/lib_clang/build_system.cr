require "./error_code"
require "./string"

lib LibClang
  type VirtualFileOverlay = Void*
  type ModuleMapDescriptor = Void*

  fun get_build_session_timestamp = clang_getBuildSessionTimestamp() : ULongLong

  fun virtual_file_overlay_create = clang_VirtualFileOverlay_create(UInt) : VirtualFileOverlay
  fun virtual_file_overlay_add_mapping = clang_VirtualFileOverlay_addFileMapping(VirtualFileOverlay, Char *, Char*) : ErrorCode
  fun virtual_file_overlay_set_case_sensitivity = clang_VirtualFileOverlay_setCaseSensitivity(VirtualFileOverlay, Int) : ErrorCode
  fun virtual_file_overlay_write_to_buffer = clang_VirtualFileOverlay_writeToBuffer(VirtualFileOverlay, UInt, Char**, UInt*) : ErrorCode
  fun free = clang_free(Void*) : Void
  fun virtual_file_overlay_dispose = clang_VirtualFileOverlay_dispose(VirtualFileOverlay) : Void

  fun module_map_descriptor_create = clang_ModuleMapDescriptor_create(UInt) : ModuleMapDescriptor
  fun module_map_descriptor_set_framework_module_name = clang_ModuleMapDescriptor_setFrameworkModuleName(ModuleMapDescriptor, Char*) : ErrorCode
  fun module_map_descriptor_set_umbrella_header = clang_ModuleMapDescriptor_setUmbrellaHeader(ModuleMapDescriptor, Char*) : ErrorCode
  fun module_map_descriptor_write_to_buffer = clang_ModuleMapDescriptor_writeToBuffer(ModuleMapDescriptor, UInt, Char**, UInt*) : ErrorCode
  fun module_map_descriptor_dispose = clang_ModuleMapDescriptor_dispose(ModuleMapDescriptor) : Void
end
