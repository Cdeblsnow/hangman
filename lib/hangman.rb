
contents = File.readlines('google-10000-english-no-swears.txt').map {|line| line.strip}
contents.delete_if{|word| word.length < 5 || word.length > 12}
number = rand(7557)


guess_word_array = Array.new(contents[number].length, "-")
word_array = contents[number].chars
incorrect_letters_array = Array.new
win = "false"



loop do 
    index = []
    puts "Please pick a letter"
    player_gues = gets.downcase.chomp

    if word_array.include?(player_gues) == true
        word_array.each_with_index { |l, i| index.push(i) if l == player_gues }
        index.each do |position|
          guess_word_array[position] = player_gues
        end
    else
        incorrect_letters_array.push(player_gues)
    end

    puts "Word: #{guess_word_array}"
    puts "Wrong letters #{incorrect_letters_array}"
    p word_array
end