
# AOC 2015 8-1

# from a c/c of input-modified file in iex:
stringLength = 4860

file = File.read!("8-input.txt")
split = String.split(file, "\n")
totalLength = String.length(file) - length(split) + 1
IO.puts "#{totalLength - stringLength}"
