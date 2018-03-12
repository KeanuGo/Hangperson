
class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses, :word_with_guesses, :check_win_or_lose, :m
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = ''
    @word.length.times { @word_with_guesses += '-' }
    @check_win_or_lose=:show
    @m=''
  end

  def guess(guessed_letter)
    @m=''
    if(guessed_letter == nil || guessed_letter == '')
      @m="Invalid guess."
      raise ArgumentError
      return false
    end

    isLetter = false
    for i in 'a'..'z' 
      if(guessed_letter.downcase == i)
        isLetter = true
        break
      end
    end

    if(!isLetter)
      @m="Invalid guess."
      raise ArgumentError
      return false
    end

    for i in 0...@word.length 
      if(@word[i] == guessed_letter)
        @word_with_guesses[i] = guessed_letter
      end
    end

    bool = false
    for i in 0...@word_with_guesses.length
      if(@word_with_guesses[i] == '-')
        bool = true
      end
    end
    if(bool)
      @check_win_or_lose = :play
    else
      @check_win_or_lose = :win
    end

    guessed_letter.downcase!
    if(word.include?(guessed_letter))
      if(@guesses.include?(guessed_letter))
        @m= "You have already used that letter."
        @guesses += ''
        @wrong_guesses += ''
        return false
      else
        @guesses += guessed_letter
        @wrong_guesses += ''
        return true
      end
    else
      if(@wrong_guesses.include?(guessed_letter))
      @m= "You have already used that letter."
        @guesses += ''
        @wrong_guesses += ''
        return false
      else
        @guesses += ''
        @wrong_guesses += guessed_letter
        if(@wrong_guesses.length == 7)
          @check_win_or_lose = :lose
        end
        return false
      end
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
