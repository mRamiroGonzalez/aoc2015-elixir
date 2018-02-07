
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


# 1 - IO.inspect each line of 8-input.txt
# 2 - copy the lines printed in the console
# 3 - paste the lines in a new file
file2 = File.read!("8-input-modified-2.txt")
split2 = String.split(file, "\n")
escapedFileLength = String.length(file2) - length(split2) + 1
IO.puts "Answer step 2: #{escapedFileLength - baseFileLength}"