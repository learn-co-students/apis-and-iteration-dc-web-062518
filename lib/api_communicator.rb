require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  results = character_hash["results"]
  character_films = []
  results.each do |person|
    if person["name"] == character
  
      character_films << person["films"]
    end
  end
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  film_collection = []

  character_films[0].each do |url|
    film_info = RestClient.get(url)
    film_info_hash = JSON.parse(film_info)
    film_collection << film_info_hash
  end

  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  return film_collection


end


  #`parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.


def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  num = 1
  puts "This character appears in:"
  films_hash.each do |info_log|
    puts "#{num}. Episode #{info_log["episode_id"]} - #{info_log["title"]} - Directed by: #{info_log["director"]}"
    num+=1
  end

end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
