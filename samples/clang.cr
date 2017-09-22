require "../src/clang"

class Parser
  protected getter index : Clang::Index
  protected getter translation_unit : Clang::TranslationUnit

  def self.parse(header_name, args = [] of String)
    parser = new(header_name, args)
    parser.parse
    parser
  end

  def initialize(header_name, args = [] of String)
    files = [
      Clang::UnsavedFile.new("input.c", "#include <#{header_name}>\n")
    ]
    options = Clang::TranslationUnit.default_options |
      Clang::TranslationUnit::Options.flags(DetailedPreprocessingRecord, SkipFunctionBodies)

    @index = Clang::Index.new
    @translation_unit = Clang::TranslationUnit.from_source(index, files, args, options)
  end

  def parse
    translation_unit.cursor.visit_children do |cursor|
      case cursor.kind
      when .macro_definition? then visit_define(cursor, translation_unit)
      when .typedef_decl?     then visit_typedef(cursor)
      when .enum_decl?        then visit_enum(cursor) unless cursor.spelling.empty?
      when .struct_decl?      then visit_struct(cursor) unless cursor.spelling.empty?
      when .union_decl?       then visit_union(cursor)
      when .function_decl?    then visit_function(cursor)
      when .var_decl?         then visit_var(cursor)
      when .macro_expansion?, .macro_instantiation?, .inclusion_directive?
        # skip
      else
        puts "warning: unexpected #{cursor.kind} children"
      end
      Clang::ChildVisitResult::Continue
    end
  end

  def visit_define(cursor, translation_unit)
    # TODO: analyze the tokens to build the constant value (e.g. type cast, ...)
    # TODO: parse the result String to verify it is valid Crystal

    value = String.build do |str|
      previous = nil
      translation_unit.tokenize(cursor.extent, skip: 1) do |token|
        case token.kind
        when .comment?
          next
        when .punctuation?
          break if token.spelling == "#"
        when .literal?
          parse_literal_token(token.spelling, str)
          previous = token
          next
        else
          str << ' ' if previous
        end
        str << token.spelling
        previous = token
      end
    end

    puts [:define, cursor.spelling, value].inspect
  end

  private def parse_literal_token(literal, io)
    if literal =~ /^((0[xo])?([+\-0-9A-F.e]+))(F|L|UL|LL|ULL)?$/i
      number, prefix, digits, suffix = $1, $2?, $3, $4?

      if prefix == "0x" && suffix == "F" && digits.size.odd?
        # false-positive: matched 0xFF, 0xffff, ...
        io << literal
      else
        case suffix.try(&.upcase)
        when "L"
          if number.index('.')
            # TODO: may be 64, 80 or 128 bits precision (see https://en.wikipedia.org/wiki/Long_double)
            io << number # << "_f128"
          else
            io << "LibC::Long.new(" << number << ")"
          end
        when "F"   then io << number << "_f32"
        when "UL"  then io << "LibC::ULong.new(" << number << ")"
        when "LL"  then io << "LibC::LongLong.new(" << number << ")"
        when "ULL" then io << "LibC::ULongLong.new(" << number << ")"
        else            io << number
        end
      end
    else
      io << literal
    end
  end

  def visit_typedef(cursor)
    cursor.visit_children do |c|
      case c.kind
      when .struct_decl?
        case c.spelling
        when .empty?
          visit_struct(c, cursor.spelling)
        when cursor.spelling
          # skip
        else
          p [:typedef, cursor.spelling, c.spelling]
        end
      when .enum_decl?
        case c.spelling
        when .empty?
          visit_enum(c, cursor.spelling)
        when cursor.spelling
          # skip
        else
          p [:typedef, cursor.spelling, c.spelling]
        end
      else
        # TODO: visit_typedef support more types
        puts "warning: unexpected #{c.kind} within #{cursor.kind}"
      end
      Clang::ChildVisitResult::Continue
    end
  end

  def visit_enum(cursor, spelling = cursor.spelling)
    type = cursor.enum_decl_integer_type #.canonical_type
    p [:enum, spelling, type.kind, type.spelling]

    cursor.visit_children do |c|
      case c.kind
      when .enum_constant_decl?
        value = case type.kind
                when .u_int? then c.enum_constant_decl_unsigned_value
                else              c.enum_constant_decl_value
                end
        print "  "
        p [:enum_constant, c.spelling, value]
      else
        puts "warning: unexpected #{c.kind} within #{cursor.kind}"
      end
      Clang::ChildVisitResult::Continue
    end
  end

  def visit_struct(cursor, spelling = cursor.spelling)
    args = [] of Array(Symbol | String | Clang::TypeKind)

    cursor.visit_children do |c|
      case c.kind
      when .field_decl?
        args << [:field, c.spelling, c.type.kind, c.type.spelling]
      when .struct_decl?
        # FIXME: inner anonymous struct
        p [:inner_struct, c.type.kind, c.type.spelling]
        #if (s = c.type.spelling).empty?
        #  s = "#{spelling}_#{c.spelling}"
        #else
        #end
        visit_struct(c)
        args << [:field, c.spelling, c.type.kind, c.type.spelling]
      else
        puts "warning: unexpected #{c.kind} within #{cursor.kind}"
      end
      Clang::ChildVisitResult::Continue
    end

    p [:struct, spelling]
    args.each do |field|
      print "  "
      puts field.inspect
    end
  end

  def visit_union(cursor)
    p [:union, cursor.spelling]
    # TODO: visit_union
  end

  def visit_function(cursor)
    arguments = cursor.arguments
    return_type = cursor.result_type #.canonical_type

    puts [:function, cursor.spelling].inspect
    arguments.each do |c|
      type = c.type.canonical_type
      print "  "
      p [:parm, c.spelling, type.kind, type.spelling]
    end
    print "  "
    p [:return, return_type.kind, return_type.spelling]
  end

  def visit_var(cursor)
    type = cursor.type #.canonical_type
    p [:var, cursor.spelling, type.kind, type.spelling]
  end
end

parser = Parser.parse(ARGV[0]? || "clang-c/Documentation.h", [
  "-I/usr/include",
  "-I/usr/lib/llvm-3.9/include",
])
