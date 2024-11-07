
require "csv"
require "json"

def pick_a_word

    contents = (File.readlines("google-10000-english-no-swears.txt").map {|line| line.strip})
    contents.delete_if{|word| word.length < 5 || word.length > 12} 
    number = rand(7557)
    word = contents[number]

end

def save_game(guess_arr,word_arr,incorrect_array,lives)
    
    data = { guess_arr: guess_arr,
             word_arr: word_arr,
             incorrect_array: incorrect_array,
             lives: lives}

    
     myfile =  if File.exist?("save.json") #make sure the file exist
                JSON.parse(File.read("save.json"))
            else
                []
            end
    
           
    myfile << data 

    File.open("save.json", "w") do |file|
        file.write(JSON.pretty_generate(myfile)) #save everything
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

            my_save = if File.exist?("save.json")
                        JSON.parse(File.read("save.json"))
                    else 
                        []
                    end

            list_of_saves = []

            my_save.each_with_index do |game, index|
              progress = game["guess_arr"]
              list_of_saves.push(progress)
              puts "#{index + 1}. #{progress}"
            end

                

                
                
                
        when "3"
            break
                
    end
end
