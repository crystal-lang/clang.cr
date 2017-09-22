require "./c2cr/parser"

#  /usr/include
#  /usr/lib/llvm-5.0/include
#  /usr/lib/llvm-5.0/lib/clang/5.0.0/include # C++
includes = ["-I/usr/include"]
header = nil

i = -1
while arg = ARGV[i += 1]?
  case arg
  when "-I"
    includes << "-I#{ARGV[i += 1]}"
  when .starts_with?("-I")
    includes << arg
  when .ends_with?(".h")
    header = arg
  else
    puts "Unknown option: #{arg}"
  end
end

parser = C2CR::Parser.new(header.not_nil!, includes)

puts "lib LibC"
parser.parse
puts "end"
