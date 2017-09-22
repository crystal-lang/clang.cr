require "./type_kind"

module Clang
  struct Type
    def initialize(@type : LibClang::Type)
    end

    def kind
      @type.kind
    end

    def spelling
      Clang.string(LibClang.getTypeSpelling(self))
    end

    def objc_type_encoding
      Clang.string(LibClang.type_getObjCEncoding(self))
    end

    def canonical_type
      Type.new(LibClang.getCanonicalType(self))
    end

    def cursor
      Cursor.new(LibClang.getTypeDeclaration(self))
    end

    def const_qualified?
      LibClang.isConstQualifiedType(self) == 1
    end

    def volatile_qualified?
      LibClang.isVolatileQualifiedType(self) == 1
    end

    def restrict_qualified?
      LibClang.isRestrictQualifiedType(self) == 1
    end

    def pointee_type
      # TODO: restrict to Pointer, BlockPointer, ObjCObjectPointer, MemberPointer
      Type.new(LibClang.getPointeeType(self))
    end

    def calling_conv
      # TODO: restrict to FunctionProto, FunctionNoProto
      LibClang.getFunctionTypeCallingConv(self)
    end

    def result_type
      # TODO: restrict to FunctionProto, FunctionNoProto
      Type.new(LibClang.getResultType(self))
    end

    def arguments
      # TODO: restrict to FunctionProto, FunctionNoProto
      Array(Type).new(LibClang.getNumArgTypes(self)) do |i|
        Type.new(LibClang.getArgType(self, i))
      end
    end

    def variadic?
      # TODO: restrict to FunctionProto, FunctionNoProto
      LibClang.isFunctionTypeVariadic(self) == 1
    end

    def pod?
      LibClang.isPODType(self) == 1
    end

    def element_type
      Type.new(LibClang.getElementType(self))
    end

    def num_elements
      LibClang.getNumElements(self)
    end

    def array_element_type
      # TODO: restrict to ConstantArray, IncompleteArray, VariableArray, DependentSizedArray
      Type.new(LibClang.getArrayElementType(self))
    end

    def array_size
      # TODO: restrict to ConstantArray
      LibClang.getArraySize(self)
    end

    def named_type
      Type.new(LibClang.type_getNamedType(self))
    end

    def align_of
      LibClang.type_getAlignOf(self)
    end

    def class_type
      Type.new(LibClang.type_getClassType(self))
    end

    def size_of
      LibClang.type_getSizeOf(self)
    end

    def offset_of(field_name)
      LibClang.type_getOffsetOf(self, field_name)
    end

    def template_arguments
      # TODO: restrict to FunctionProto, FunctionNoProto
      Array(Type).new(LibClang.type_getNumTemplateArguments(self)) do |i|
        Type.new(LibClang.type_getTemplateArgumentAsType(self, i))
      end
    end

    def cxx_ref_qualifier
      # TODO: restrict to FunctionProto, FunctionNoProto
      LibClang.type_getCXXRefQualifier(self)
    end

    def to_unsafe
      @type
    end

    def inspect(io)
      io << "<##{self.class.name} kind=#{kind} spelling=#{spelling}>"
    end

    def inspect(io)
      io << "<#"
      io << self.class.name
      io << " kind="
      io << kind
      io << " spelling="
      spelling.inspect(io)
      io << ">"
    end
  end
end
