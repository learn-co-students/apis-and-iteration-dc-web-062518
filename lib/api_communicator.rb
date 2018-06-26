require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters.body)

  results_array = character_hash["results"]
  the_answer = []
  results_array.each do |character_info|
    if character_info["name"] == character
       character_info["films"].each do |url|
         movie_name = RestClient.get(url)
         movie_name_hash = JSON.parse(movie_name.body)
         the_answer << movie_name_hash["title"]
       end
    end
  end
puts the_answer
end
