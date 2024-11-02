
def pick_a_word
    contents = (File.readlines('google-10000-english-no-swears.txt').map {|line| line.strip})
    contents.delete_if{|word| word.length < 5 || word.length > 12} # we need to pick a new word in case of new game
    number = rand(7557)
    word = contents[number]

end


word = pick_a_word
number_of_attemps = word.length
win = false

guess_word_array = Array.new(word.length, "-") # create the new arrays when a new word is pick
word_array = word.chars
incorrect_letters_array = Array.new

options = {

    "1" => "New game",
    "2" => "Load game",
    "3" => "Quit"
}

loop do 

    puts "Welcome, please select an option"
    options.each {|key,value| puts "#{key}. #{value}"}
    choice = gets.chomp

    case choice

        when "1" || "y"

            loop do 

                index = []
                puts "Please pick a letter"
                puts ""
                puts "You have #{number_of_attemps} tries left"
                player_gues = gets.downcase.chomp
            
                if word_array.include?(player_gues) == true
                    word_array.each_with_index { |l, i| index.push(i) if l == player_gues }
                    index.each do |position|
                    guess_word_array[position] = player_gues #this can be made in a line
                    end
                else
                    incorrect_letters_array.push(player_gues)
                    number_of_attemps = number_of_attemps - 1
                end
                
                win = true if guess_word_array == word_array

                if win == true 
                  puts "Congratulations, you have won!"
                  puts ""
                  # make all the new selections here
                    break
                elsif number_of_attemps == 0
                    puts "Sorry, you have lost :( "
                    break    
                end

                puts "Word: #{guess_word_array}"
                puts "Wrong letters #{incorrect_letters_array}"
                p word_array
                puts ""
            
            end
        
        when "2"
        # work in progress
        when "3"
            break
                
    end
end
