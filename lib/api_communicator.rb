require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  all_films = []
  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  character_hash["results"].each do |person_hash|
    if person_hash["name"].downcase == character
      all_films = person_hash["films"]
    end
  end
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film

  #Alternative Solution:

  # movie_titles = []
  # all_films.each do |links|
  #   movie_page = RestClient.get(links)
  #   movie_hash = JSON.parse(movie_page)
  #   movie_titles << movie_hash["title"]
  # end
  # return value of this method should be collection of info about each film.
  movie_titles(all_films)
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def movie_titles(all_films)
  movie_titles = []
  all_films.each do |links|
    movie_page = RestClient.get(links)
    movie_hash = JSON.parse(movie_page)
    movie_titles << movie_hash["title"]
  end
  movie_titles
end

def parse_character_movies(films_hash)
  films_hash.each_with_index do | title, index|
    puts "#{index + 1} #{title}"
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
