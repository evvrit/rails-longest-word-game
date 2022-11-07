require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = ('a'..'z').to_a.shuffle[0,10]
  end

  def score
    if params[:word]
      # @message = params[:tiles]
      @tiles = params[:tiles]
      (params[:word].split('')).each do |letter|
        if @tiles.include?(letter)
          response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read
          if JSON.parse(response)["found"]
            @message = "Congratulations! #{params[:word].upcase} is a valid English word!"
          else
            @message = "Sorry but #{params[:word].upcase} does not appear to be a valid English word..."
          end
        else
          @message = "Sorry but #{params[:word]} can't be built out of #{@tiles}"
        end
      end
    end
  end
end
