
# AOC 2015 8-2

# 1 - IO.inspect each line of 8-input.txt
# 2 - copy the lines printed in the console
# 3 - paste the lines in a new file
file = File.read!("8-input.txt")
file2 = File.read!("8-input-modified-2.txt")

split2 = String.split(file, "\n")
baseFileLength = String.length(file) - length(split2) + 1
escapedFileLength = String.length(file2) - length(split2) + 1

IO.puts "Answer step 2: #{escapedFileLength - baseFileLength}"