class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  attr_reader :word
  attr_reader :guesses
  attr_reader :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(letter)
    raise ArgumentError, "Letter should not be empty" unless letter != ""
    raise ArgumentError, "Letter should be a letter" unless letter =~ /^[a-zA-Z]+$/i
    raise ArgumentError, "Letter should not be nil" unless letter != nil
    letter.downcase!
    return false if @guesses.include?(letter) || @wrong_guesses.include?(letter)

    if @word.include? letter
      @guesses += letter
    else
      @wrong_guesses += letter
    end
    true
  end

  def word_with_guesses
    output = ""
    @word.each_char { |e|
      if @guesses.include? e
        output += e
      else
        output += "-"
      end
    }
    output
  end

  def check_win_or_lose
    return :win if @guesses.length == @word.length
    return :lose if @wrong_guesses.length >= 7
    :play
  end

end
