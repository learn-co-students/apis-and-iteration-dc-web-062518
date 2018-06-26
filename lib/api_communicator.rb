require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  results = character_hash["results"]
  arr = []


  results.each do |item|
    if item["name"] == character
      item.each do |key, value|
        if key == "films"
          value.each do |film|
            sw_film = RestClient.get(film)
            film_hash = JSON.parse(sw_film)
            # film_hash = parse_character_movies(sw_film)
            arr << film_hash["title"]
          end
        end
      end
    end
  end
  # binding.pry
  arr.each_with_index do |film,index|
    puts "#{index+1} #{film}"
  end

end

get_character_movies_from_api("Luke Skywalker")



# def parse_character_movies(films_hash)
#   movie_hash = JSON.parse(films_hash)
#   movie_hash
# end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
