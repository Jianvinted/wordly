class CheckWordController < ApplicationController
    helper_method :check_word_colouring, :show_scorecard
    WORD_SYMBOLS = [:word1, :word2, :word3, :word4, :word5, :word6]
    
    def index
        word_session
        @words = words
        @submitted_words_count = submitted_words_count
        @submitted_word_symbols = WORD_SYMBOLS.take(submitted_words_count)
        @next_word_symbol = WORD_SYMBOLS[submitted_words_count]
        @debug_me = word_of_the_day
        @word_of_the_day = word_of_the_day
        @check_word = check_word
        @alphabet = alphabet    
        @one_game_per_day = one_game_per_day
        @logged_as_secretuser = logged_as_secretuser
        
        

        #Saving won/lost games when logged in
        save_game

    end

    private

    def logged_as_secretuser
       if session[:user_id].nil?
        false 
       elsif
        @user = User.find_by(id: session[:user_id])
            if @user.username == "secretuser"
                true
            elsif 
                false
            end                
       end
    end 

    def show_scorecard
        redirect_to check_word_path and return
    end 

    def save_game
        if @one_game_per_day && session[:user_id] && (@check_word == "YOU WON" || @check_word == "TRY ANOTHER DAY")
            @game 
            @row = @submitted_word_symbols.last.to_s[4]

                if @check_word == "YOU WON"
                    @game ||= Game.new(status: true, row: @row, user_id: session[:user_id])
                elsif
                    @game ||= Game.new(status: false, row: @row, user_id: session[:user_id])
                end
                @game.save
        end

    end 

    def submitted_words_count
      words.select { |_, v| v != '' }.count
    end


    def word_session
        WORD_SYMBOLS.each do | n |
            session[n] = params[n.to_s] if session[n].nil?
        end
    end 

    def words                
        {:word1 => session[:word1] || '' ,
        :word2 => session[:word2] || ''  ,
        :word3 => session[:word3] || ''  ,
        :word4 => session[:word4] || ''  ,
        :word5 => session[:word5] || ''  ,
        :word6 => session[:word6] || ''  }
    end

    def check_word
        if last_submitted_word[:word] ==  nil 
            "GUESS THE WORD"
        elsif last_submitted_word[:word].upcase ==  word_of_the_day
            "YOU WON"
        elsif last_submitted_word[:word_nr] == :word6 && last_submitted_word[:word] !=  word_of_the_day
            "TRY ANOTHER DAY"
        else
           "GUESS ANOTHER WORD"  
        end
    end

    def alphabet
        ('A'..'Z').to_h { |letter| [letter, ""] }
    end

    def check_word_colouring (correct_word, guess_word)
        
        colours = Array.new

        guess_word.each_char.each_with_index do |letter, index|
            letter.upcase!
            if letter == correct_word[index]
                colour = '#ccfecf;'
                @alphabet[letter] = colour
            elsif correct_word.include?(letter)
                colour = '#fef9cc;'
                (@alphabet[letter] = colour) unless @alphabet[letter] == '#ccfecf;'
            else
                colour = '#ddd;'
                @alphabet[letter] = colour
            end

           colours.append(colour)
        end

        colours

        ## '#ccfecf' -> green  '#fef9cc' -> yellow  '#ddd' ->  grey
    end

    def last_submitted_word
        {
            :word_nr => @submitted_word_symbols.last ,
            :word => @words[@submitted_word_symbols.last]
        }
    end 

    def word_of_the_day
        file = File.open("#{Rails.root}/words/words.txt")
        file_data = file.readlines.map { |line| line.strip }
        the_word = file_data[Time.new.year % 100 + Date.today.yday()*25]
        
        file.close

        the_word.upcase!
    end 

    def one_game_per_day
        if session[:user_id].nil?
            true 
        elsif
            @user_games = Game.where(user_id: session[:user_id]) 
            if @user_games.empty?
                true
            elsif 
                last_date_game = @user_games.last.created_at
                last_date_game.to_date + 1.day != Date.tomorrow
            end
        

        end
    end


end

#    def one_game_per_day
#        @current_user = User.new(user: cookies[:user_id])
#        @current_user = User.new(user_params)
#        if params[:remember_date]
#            cookies[:user_id] = @current_user.user
#        if @check_word == "YOU WON" || @check_word == "TRY ANOTHER DAY" && session[:user_id] == current_user
#            render "wordly/index"
#        else
#
#        end
#    end
