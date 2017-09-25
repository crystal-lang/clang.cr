require "./c2cr/parser"

def default_include_directories(cflags)
  # args = {"-E", "-x", "c++", "-", "-v"}  # C++
  args = {"-E", "-", "-v"}                 # C
  Process.run("c++", args, shell: true, error: io = IO::Memory.new)

  includes = [] of String
  found_include = false

  io.rewind.to_s.each_line do |line|
    if line.starts_with?("#include ")
      found_include = true
    elsif found_include
      line = line.lstrip
      break unless line.starts_with?('.') || line.starts_with?('/')
      includes << line.chomp
    end
  end

  includes.reverse_each do |path|
    cflags.unshift "-I#{path}"
  end
end

cflags = [] of String
header = nil
remove_enum_prefix = remove_enum_suffix = false

if arg = ENV["CFLAGS"]?
  cflags += arg.split(' ').reject(&.empty?)
end

i = -1
while arg = ARGV[i += 1]?
  case arg
  when "-I", "-D"
    cflags << "#{cflags}#{ARGV[i += 1]}"
  when .starts_with?("-I"), .starts_with?("-D")
    cflags << arg
  when .ends_with?(".h")
    header = arg

  when "--remove-enum-prefix"
    remove_enum_prefix = true
  when .starts_with?("--remove-enum-prefix=")
    case value = arg[21..-1]
    when "", "false" then remove_enum_prefix = false
    when "true" then remove_enum_prefix = true
    else remove_enum_prefix = value
    end

  when "--remove-enum-suffix"
    remove_enum_suffix = true
  when .starts_with?("--remove-enum-suffix=")
    case value = arg[21..-1]
    when "", "false" then remove_enum_suffix = false
    when "true" then remove_enum_suffix = true
    else remove_enum_suffix = value
    end

  else
    abort "Unknown option: #{arg}"
  end
end

default_include_directories(cflags)

parser = C2CR::Parser.new(
  header.not_nil!,
  cflags,
  remove_enum_prefix: remove_enum_prefix,
  remove_enum_suffix: remove_enum_suffix,
)

puts "lib LibC"
parser.parse
puts "end"
