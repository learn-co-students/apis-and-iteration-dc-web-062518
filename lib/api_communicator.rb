require 'rest-client'
require 'json'
require 'pry'

def get_films_with_character_from_api(character)
  #make the web request
  films = []
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  character_hash['results'].each do |arr|
    if arr['name'].downcase == character
      films = arr['films']
    end
  end
  films
end

def get_info_with_films_from_api(films)
  film_data = []
  films.each do |arr_f|
    film_data << RestClient.get(arr_f)
  end
  film_arr = []
  film_data.each do |arr_d|
  film_arr << JSON.parse(arr_d)
  end
  return film_arr
end

def get_character_movies_from_api(film_arr)
#working on the arr of the films of the specific character
arr2 = []
film_arr.each do |arr_f2|
  arr_f2.each do |key, value|
    if key == 'title'
      arr2 << value
    end
  end
end


return film_arr

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  arr = []
  films_hash.each_with_index do |arr_f, index|
    arr_f.each do |key, value|
      if key == 'title'
        puts "#{index+1}-  #{value}"
      end
    end
  end
end

def show_character_movies(character)
  films = get_films_with_character_from_api(character)
  film_arr = get_info_with_films_from_api(films)
  films_hash = get_character_movies_from_api(film_arr)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
