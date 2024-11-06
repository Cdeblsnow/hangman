
require "csv"

def pick_a_word

    contents = (File.readlines("google-10000-english-no-swears.txt").map {|line| line.strip})
    contents.delete_if{|word| word.length < 5 || word.length > 12} 
    number = rand(7557)
    word = contents[number]

end

def save_game(guess_arr,word_arr,incorrect_array,lives)
    
    Dir.mkdir("save") unless Dir.exist?("save")

    CSV.open('save.csv', 'a') do |csv|
      csv << ["current_guess_progress","word_array",
              "incorrect words array", "lives"] if File.zero?("save.csv")
      csv << [guess_arr,word_arr,incorrect_array,lives] # i need an id to recall the saved games or recall by guess_arr
    end

end

def load_game
  
end

options = {

    "1" => "New game",
    "2" => "Load game",
    "3" => "Quit"
}

loop do 

    word = pick_a_word
    number_of_attemps = word.length
    win = false

    guess_word_array = Array.new(word.length, "-") #player visual help
    word_array = word.chars #comparision array
    incorrect_letters_array = Array.new

    puts ""
    puts "Welcome, please select an option"
    options.each {|key,value| puts "#{key}. #{value}"}
    choice = gets.chomp

    case choice

        when "1" || "y"

            loop do 

                index = []
                puts "Please pick a letter"
                puts ""
                puts "Word: #{guess_word_array}"
                puts "Wrong letters #{incorrect_letters_array}"
                puts "You have #{number_of_attemps} tries left"
                puts "You can save the game at anytime by writing 'save'"
                player_gues = gets.downcase.chomp
            
                if player_gues == "save"
                    game = save_game(guess_word_array,word_array,incorrect_letters_array,number_of_attemps)
                    puts "Your gave have been saved!"
                    break

                elsif word_array.include?(player_gues) == true
                    word_array.each_with_index { |l, i| index.push(i) if l == player_gues }
                    index.each do |position|#this can be made in a line
                    guess_word_array[position] = player_gues #this can be made in a line
                    end

                else
                    incorrect_letters_array.push(player_gues)
                    number_of_attemps = number_of_attemps - 1

                end
                
                win = true if guess_word_array == word_array

                if win == true 
                  puts ""
                  puts "Congratulations, you have won!"
                  puts ""
                    break

                elsif number_of_attemps == 0
                    puts "Sorry, you have lost :( "
                    break  

                end
                       
                p word_array #remove this
                puts ""
            
            end
        
        when "2"
            contents = CSV.open(
                'save.csv', 
                headers: true,
                header_converters: :symbol
                ) 
                id = 0
                array_progress = []
                contents.each do |row|
                    id += 1
                  progress = row[:current_guess_progress]
                  array_progress.push(progress)
                  puts "#{id}. #{progress}"
                end
                puts "which game would you like to load?"
                answer = gets.chomp.to_i
                puts "#{array_progress[answer-1]} is loading"
        when "3"
            break
                
    end
end
