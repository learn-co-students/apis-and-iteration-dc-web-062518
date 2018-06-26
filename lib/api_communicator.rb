require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  films_arr = []
  # binding.pry
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.

  character_hash["results"].each do |item|
    if item['name'] == character
      item.each do |key,value|
        if key == "films"
          value.each do |film|
            sw_film = RestClient.get(film)
            film_hash = JSON.parse(sw_film)
            # film_hash = parse_character_movies(sw_film)
            films_arr << film_hash["title"]
          end
        end
      end
    end
  end
  # binding.pry
  films_arr.each_with_index do |film,index|
    puts "#{index+1}. #{film}"
  end
end

# def get_character(hash)
#   name = hash["results"][0]["name"]
#   binding.pry
# end
get_character_movies_from_api("Luke Skywalker")

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  movie_hash = JSON.parse(films_hash)
  movie_hash
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end


# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
