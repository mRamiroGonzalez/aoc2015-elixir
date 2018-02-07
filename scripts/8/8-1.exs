
# AOC 2015 8-1

# 1 - manually (ctrl A / Alt+Maj+I on vscode) remove all \n
# 2 - remove quotes on start and end of lines, except the fist and last one of the file
# 3 - copy the result and paste in iex
# 4 - String.length on the pasted string
stringLength = 4860
file = File.read!("8-input.txt")

split = String.split(file, "\n")
baseFileLength = String.length(file) - length(split) + 1

IO.puts "Answer step 1: #{baseFileLength - stringLength}"