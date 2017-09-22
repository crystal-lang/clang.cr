# This sample parses a C header file, and prints all Clang cursors to STDOUT.

require "../src/clang"

def visit(parent, deep = 0)
  parent.visit_children do |cursor|
    if deep == 0
      unless cursor.kind.macro_definition? ||
          cursor.kind.macro_expansion? ||
          cursor.kind.inclusion_directive?
        puts
      end
    else
      print " " * deep
    end

    puts "#{cursor.kind}: spelling=#{cursor.spelling} type.kind=#{cursor.type.kind} type.spelling=#{cursor.type.spelling.inspect} at #{cursor.location}"

    visit(cursor, deep + 2)

    Clang::ChildVisitResult::Continue
  end
end

index = Clang::Index.new

file_name = ARGV[0]? || "clang-c/Documentation.h"
files = [
  Clang::UnsavedFile.new("input.c", "#include <#{file_name}>\n")
]
args = [
  "-I/usr/include",
  "-I/usr/lib/llvm-3.9/include",
]
options = Clang::TranslationUnit.default_options |
  Clang::TranslationUnit::Options::DetailedPreprocessingRecord

tu = Clang::TranslationUnit.from_source(index, files, args, options)

visit(tu.cursor)
