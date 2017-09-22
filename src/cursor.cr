require "./cursor_kind"
require "./platform_availability"
require "./eval_result"

module Clang
  alias ChildVisitResult = LibClang::ChildVisitResult
  alias Linkage = LibClang::LanguageKind
  alias Availability = LibClang::LanguageKind
  alias Visibility = LibClang::LanguageKind
  alias Language = LibClang::LanguageKind
  alias AccessSpecifier = LibClang::AccessSpecifier
  alias StorageClass = LibClang::StorageClass

  struct Cursor
    def initialize(@cursor : LibClang::Cursor)
    end

    def ==(other : Cursor)
      LibClang.equalCursors(self, other) != 0
    end

    def ==(other)
      false
    end

    def kind
      @cursor.kind
    end

    def type
      Type.new(LibClang.getCursorType(self))
    end

    def visit_children(&block : Cursor -> ChildVisitResult)
      LibClang.visitChildren(self, ->(cursor, parent, data) {
        proc = Box(typeof(block)).unbox(data)
        proc.call(Cursor.new(cursor))
      }, Box.box(block))
    end

    def has_attributes?
      LibClang.cursor_hasAttrs(self) == 1
    end

    def language
      LibClang.getCursorLanguage(self)
    end

    def hash
      LibClang.hashCursor(self)
    end

    def linkage
      LibClang.getCursorLinkage(self)
    end

    def visibility
      LibClang.getCursorVisibility(self)
    end

    def availability
      LibClang.getCursorAvailability(self)
    end

    def platform_availability
      LibClang.getCursorPlatformAvailability(self, nil, nil, nil, nil, out availability, out size)
      Array(PlatformAvailability).new(size).new { |i| PlatformAvailability.new(availability[i]) }
    end

    def semantic_parent
      Cursor.new LibClang.getCursorSemanticParent(self)
    end

    def lexical_parent
      Cursor.new LibClang.getCursorLexicalParent(self)
    end

    # def included_file
    #   File.new(LibClang.getIncludedFile(self))
    # end

    def location
      SourceLocation.new(LibClang.getCursorLocation(self))
    end

    def extent
      LibClang.getCursorExtent(self)
    end

    def overriden_cursors
      LibClang.getOverriddenCursors(self, out overriden, out size)
      Array(Cursor).new(size) { |i| Cursor.new(overriden[i]) }
    ensure
      LibClang.disposeOverriddenCursors(overriden) if overriden
    end

    def typedef_decl_underlying_type
      Type.new(LibClang.getTypedefDeclUnderlyingType(self))
    end

    def enum_decl_integer_type
      Type.new(LibClang.getEnumDeclIntegerType(self))
    end

    def enum_constant_decl_value
      raise ArgumentError.new("error: cursor is #{kind} not EnumConstantDecl") unless kind.enum_constant_decl?
      LibClang.getEnumConstantDeclValue(self)
    end

    def enum_constant_decl_unsigned_value
      raise ArgumentError.new("error: cursor is #{kind} not EnumConstantDecl") unless kind.enum_constant_decl?
      LibClang.getEnumConstantDeclUnsignedValue(self)
    end

    def field_decl_bit_width
      LibClang.getFieldDeclBitWidth(self)
    end

    def arguments
      Array(Cursor).new(LibClang.cursor_getNumArguments(self)) do |i|
        Cursor.new(LibClang.cursor_getArgument(self, i))
      end
    end

    # def template_arguments
    #   Array(???).new(LibClang.cursor_getNumTemplateArguments(self)) do |i|
    #     case LibClang.cursor_getTemplateArgumentKind(self, i)
    #     when .null?
    #     when .type?
    #     when .declaration?
    #     when .null_ptr?
    #     when .integral?
    #     when .template_expansion?
    #     when .expression?
    #     when .pack?
    #     when .invalid?
    #     end
    #   end
    # end

    def macro_function_like?
      LibClang.cursor_isMacroFunctionLike(self) == 1
    end

    def macro_builtin?
      LibClang.cursor_isMacroBuiltin(self) == 1
    end

    def function_inlined?
      LibClang.cursor_isFunctionInlined(self) == 1
    end

    def objc_type_encoding
      Clang.string(LibClang.getDeclObjCTypeEncoding(self))
    end

    def result_type
      Type.new(LibClang.getCursorResultType(self))
    end

    def offset_of_field
      LibClang.cursor_getOffsetOfField(self)
    end

    def anonymous?
      LibClang.cursor_isAnonymous(self) == 1
    end

    def bit_field?
      LibClang.cursor_isBitField(self) == 1
    end

    def virtual_base?
      LibClang.isVirtualBase(self) == 1
    end

    def cxx_access_specifier
      LibClang.getCXXAccessSpecifier(self)
    end

    def storage_class
      LibClang.cursor_getStorageClass(self)
    end

    def overloads
      Array(Cursor).new(LibClang.getNumOverloadedDecls(self)).new do |i|
        Cursor.new(LibClang.getOverloadedDecl(self, i))
      end
    end

    def ib_outlet_collection_type
      Type.new(LibClang.getIBOutletCollectionType(self))
    end


    # TODO: C++ AST introspection (lib_clang/ast.cr)



    # CROSS REFERENCING

    # Returns a raw `LibClang::String`, use `Clang.string(usr, dispose: false)`
    # to get a String.
    def usr
      LibClang.getCursorUSR(self)
    end

    # USR constructors return a raw `LibClang::String`, use
    # `Clang.string(usr, dispose: false)` to get a String.
    module USR
      def self.objc_class(name)
        LibClang.constructUSR_ObjCClass(name)
      end

      def self.objc_category(class_name, category_name)
        LibClang.constructUSR_ObjCCategory(class_name, category_name)
      end

      def self.objc_protocol(name)
        LibClang.constructUSR_ObjCProtocol(name)
      end

      def self.objc_ivar(name, class_usr : LibClang::String)
        LibClang.constructUSR_ObjCIvar(name, class_usr)
      end

      def self.objc_method(name, instance, class_usr : LibClang::String)
        LibClang.constructUSR_ObjCMethod(name, instance ? 1 : 0, class_usr)
      end

      def self.objc_property(name, class_usr : LibClang::String)
        LibClang.constructUSR_ObjCProperty(property, class_usr)
      end
    end

    def spelling
      Clang.string(LibClang.getCursorSpelling(self))
    end

    # def spelling_name_range(piece_index, options = 0)
    #   SourceRange.new(LibClang.cursor_getSpellingNameRange(self, piece_index, options))
    # end

    def display_name
      Clang.string(LibClang.getCursorDisplayName(self))
    end

    def referenced
      Cursor.new(LibClang.getCursorReferenced(self))
    end

    def definition?
      if LibClang.isCursorDefinition(self) == 1
        definition
      end
    end

    def definition
      Cursor.new(LibClang.getCursorReferenced(self))
    end

    def canonical_cursor
      Cursor.new(LibClang.getCanonicalCursor(self))
    end

    def objc_selector_index
      clang_Cursor_getObjCSelectorIndex(self)
    end

    def dynamic_call?
      LibClang.cursor_isDynamicCall(self)
    end

    def receiver_type
      Type.new(LibClang.cursor_getReceiverType(self))
    end

    def objc_property_attributes
      LibClang.cursor_getObjCPropertyAttributes(self, 0)
    end

    # def comment_range
    #   SourceRange.new(LibClang.cursor_getCommentRange(self))
    # end

    def raw_comment_text
      Clang.string(LibClang.cursor_getRawCommentText(self))
    end

    def get_bried_comment_text
      Clang.string(LibClang.cursor_getBriefCommentText(self))
    end

    def objc_decl_qualifiers
      LibClang.cursor_getObjCDeclQualifiers(self)
    end

    def objc_optional?
      LibClang.cursor_isObjCOptional(self) == 1
    end

    def variadic?
      LibClang.cursor_isVariadic(self)
    end

    # def comment_range?
    #   SourceRange.new(LibClang.cursor_getCommentRange(self))
    # end

    def evaluate
      if ptr = LibClang.cursor_Evaluate(self)
        EvalResult.new(ptr)
      end
    end

    def mangling
      Clang.string(LibClang.cursor_getMangling(self))
    end

    def cxx_manglings
      if list = LibClang.cursor_getCXXManglings(self)
        Array(String).new(list.value.count) do |i|
          Clang.string(list.value.strings[i], dispose: false)
        end
      end
    ensure
      LibClang.disposeStringSet(list) if list
    end

    def inspect(io)
      io << "<#"
      io << self.class.name
      io << " kind="
      kind.to_s(io)

      case kind
      when .cxx_access_specifier?
        io << "access=" << cxx_access_specifier
      else
        io << " spelling="
        spelling.inspect(io)
        io << " type="
        type.inspect(io)
      end

      io << ">"
    end

    def to_unsafe
      @cursor
    end
  end
end
