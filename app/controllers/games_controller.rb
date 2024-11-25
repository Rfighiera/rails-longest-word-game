class GamesController < ApplicationController

  require 'open-uri'
  require 'json'

  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters]
    @result = if word_in_grid? && in_english?
      "#{@word} is valid !"
    elsif word_in_grid?
      "#{@word} does not exist in english !"
    else
      "#{@word} is not valid !"
    end
  end

  def word_in_grid?
    @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter)}
  end

  def in_english?
    url = "https://dictionary.lewagon.com/#{@word}"
    JSON.parse(URI.open(url).read)['found']
  end
end
