class HangpersonGame

 # add the necessary class methods, attributes, etc. here
 # to make the tests in spec/hangperson_game_spec.rb pass.

  #attr_accessor :guesses, :wrong_guesses, :word, :valid, :HangPersonGame
  
  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses, :word_with_guesses, :check_win_or_lose 
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = '-' * word.length
    @check_win_or_lose = :play
  end
  
  
  def guess(letter)
    
    #Check for win
    if @check_win_or_lose == :win
      return true
    end

    
    # Check for errors
    if letter.nil?
      raise ArgumentError.new("u dun fukd ^ sun!")
    elsif letter.empty?
      raise ArgumentError.new("You didn't enter anything!")
    elsif !(letter =~ /[a-zA-Z]/)
      raise ArgumentError.new("You didn't enter a valid letter!")
    end
    
    #Repeat Letter
    letter = letter.downcase
    if @guesses.include? letter or @wrong_guesses.include? letter
      return false

    #correctly
    elsif @word.include? letter
      @guesses += letter
      for i in 0...@word.length
        if @word[i] == letter && @word_with_guesses[i] = '-'
          @word_with_guesses[i] = letter 
        end
      end
      
    gameStatus()
    
    #incorrectly
  else
    if !(@word.include? letter)
      @wrong_guesses += letter
      gameStatus()
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

 def gameStatus
    #Check for win/loss
    if @word == @word_with_guesses
      @check_win_or_lose = :win
    end
    
    if @wrong_guesses.length >= 7
      @check_win_or_lose = :lose
    elsif @guesses.length > @word.length
      @check_win_or_lose = :lose
    elsif @guesses.length == @word.length
      if @word_with_guesses == @word
        @check_win_or_lose = :win
      else
        @check_win_or_lose = :lose
     end
    end
end