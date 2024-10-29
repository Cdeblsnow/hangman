
contents = File.readlines('google-10000-english-no-swears.txt').map {|line| line.strip}
contents.delete_if{|word| word.length < 5 || word.length > 12}
number = rand(7557)

puts contents[number]

